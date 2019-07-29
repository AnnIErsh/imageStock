//
//  ImageStockViewController.m
//  finalTask
//
//  Created by Anna Ershova on 7/25/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ImageStockViewController.h"
#import "ImageStockCell.h"
#import "ViewController.h"

@interface ImageStockViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@end

@implementation ImageStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutorezingMask];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout new] autorelease];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.imageStockView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.imageStockView setDataSource:self];
    [self.imageStockView setDelegate:self];
    [self.imageStockView registerClass:[ImageStockCell class] forCellWithReuseIdentifier:@"CellStock"];
    [self.imageStockView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.imageStockView];
    self.infNumber = (arc4random_uniform(20) + 10) * 2;
    self.navigationController.navigationBar.hidden = YES;
}


-(void)setAutorezingMask{
    self.imageStockView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.infNumber;
    //+ self.imageDate.count ;
}

- (void)viewDidLayoutSubviews{
    [self.imageStockView reloadData];
    [self setAutorezingMask];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.view.frame.size.height < self.view.frame.size.width){
        return CGSizeMake(self.view.bounds.size.height / 2, self.view.bounds.size.height / 2);
    }
    
    return CGSizeMake(self.view.bounds.size.width / 2, self.view.bounds.size.width / 2);
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageStockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellStock" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"placeholder"]];
    cell.backgroundView.layer.opacity = 0.5;
    cell.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *sValue = [@(self.infNumber) stringValue];
    cell.tag = indexPath.item;
    [self fetchRequest:cell forOndexPath:indexPath withPage:sValue];
    return cell;
}


- (void)fetchRequest: (ImageStockCell *)cell forOndexPath: (NSIndexPath*)path withPage:(NSString*)page{
    NSString *client_id = @"d3f9b52149691b5f1335fbfe5d419778aa9bd0619d34a6b805d4db7f71f079f3";
    //@"b3b44601b00c840945f3c415f24e043ee5149121d2de04e4b47cb290b3401b2c";
    //b132b205e5222fb070766e967d5ce4a97019704f212a35b7db5c249131967858

    NSURLComponents *componets = [NSURLComponents new];
    componets.scheme = @"https";
    componets.host = @"api.unsplash.com";
    componets.path = @"/photos";
    componets.queryItems = @[
                             [NSURLQueryItem queryItemWithName:@"client_id" value: client_id],
                             [NSURLQueryItem queryItemWithName:@"page" value: page],
                             [NSURLQueryItem queryItemWithName:@"per_page" value: page]
                            // [NSURLQueryItem queryItemWithName:@"count" value: page]
                             ];
   // self.infNumber = self.infNumber + 1;
    NSURL *url = componets.URL;
  
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error)
        {
            NSLog(@"Error : %@\n", error);
            return;
        }
        
        if (data)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            self.imageDate = [dict valueForKey:@"urls"];
            NSArray *arr = [self.imageDate valueForKey:@"small"];
            NSString *str = [arr objectAtIndex:path.item];
            
            
            NSArray *arrId = [dict valueForKey:@"id"];
            cell.idImage = [arrId objectAtIndex:path.item];
            
            NSArray *arrAltDescription = [dict valueForKey:@"alt_description"];
            cell.altDescription = [arrAltDescription objectAtIndex:path.item];
            
            
            NSArray *arrBigImage = [self.imageDate valueForKey:@"full"];
            cell.urBigImage = [arrBigImage objectAtIndex:path.item];
            [self loadImagesInItems:cell withString:str atIndexPath:path];
            
           

        }
    }];
    [task resume];
    [componets autorelease];

    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
  //  NSLog(@"ended");
    //self.infNumber = self.infNumber + 1
     [self.imageStockView reloadData];
     self.infNumber = self.infNumber + 30;
}

-(void)loadImagesInItems:(ImageStockCell*)cell withString:(NSString*)str atIndexPath:(NSIndexPath*)path{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                 [NSURL URLWithString:str]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(image!= nil){
               // if (cell.tag == path.item){
                    [cell.stockImageView setImage:image];
               // }
            }else{
                
                [cell.stockImageView setImage:[UIImage imageNamed:@"placeholder"]];
                
            }
            
            [cell setNeedsLayout];
            [cell.stockImageView setUserInteractionEnabled: YES];
            
            
        });
    });
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ViewController *detailsVC = [[ViewController new] autorelease];
    ImageStockCell *cell = (ImageStockCell*)[self.imageStockView cellForItemAtIndexPath: indexPath];
    detailsVC.image = cell.stockImageView.image;
    
    [self.navigationController pushViewController:detailsVC animated:NO];
    
    NSString *ID = cell.idImage;
    NSString *url = cell.urBigImage;
    if(!cell.altDescription) {
        cell.altDescription = @"No description";
    }
    NSLog(@"id: %@  url: %@", ID, url);
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



@end
