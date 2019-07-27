//
//  ImageStockViewController.m
//  finalTask
//
//  Created by Anna Ershova on 7/25/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ImageStockViewController.h"
#import "ImageStockCell.h"

@interface ImageStockViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation ImageStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutorezingMask];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout new] autorelease];
    self.imageStockView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.imageStockView setDataSource:self];
    [self.imageStockView setDelegate:self];
    [self.imageStockView registerClass:[ImageStockCell class] forCellWithReuseIdentifier:@"CellStock"];
    [self.imageStockView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.imageStockView];
    self.infNumber = (arc4random() % 40) + 10;
    [self getJson];
    
 
    
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
    //ImageStockCell *cell = (ImageStockCell*)
//    UICollectionViewCell *sizingCell = [ImageStockCell sizingCell];
//    [sizingCell prepareForReuse];
//    [self configureCell:sizingCell atIndexPath:indexPath];
//    [sizingCell setNeedsLayout];
//    [sizingCell layoutIfNeeded];
//    
//    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
 //   ImageStockCell *cell = (ImageStockCell *)[self.imageStockView cellForItemAtIndexPath:indexPath];
    
    //CGSize size = cell.stockImageView.frame.size;
//     dispatch_async(dispatch_get_main_queue(), ^{
//         NSLog(@"size %f: ", cell.width);});
    
    //CGSizeMake(cell.width, cell.height);
    //cell.stockImageView.frame.size;
    
    return CGSizeMake(200, 200);
}

    
    
-(void)configureCell: (CGSize)size atIndexPath:(NSIndexPath*)path {
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageStockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellStock" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"placeholder"]];
    NSString *sValue = [@(self.infNumber) stringValue];
    cell.tag = indexPath.item;
   // [self fetchRequest:cell forOndexPath:indexPath withPage:sValue];
//
//    NSArray *arr = [self.imageDate valueForKey:@"small"];
//    NSString *str = [arr objectAtIndex:indexPath.item];
    [self fetchRequest:cell forOndexPath:indexPath withPage:sValue];
   // [self loadImagesInItems:cell withString:str atIndexPath:indexPath];
   // NSLog(@"%lu", (unsigned long)self.imageDate.count);
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
            [self.mutableImageDate addEntriesFromDictionary:dict];
            NSLog(@"%lu", (unsigned long)dict.count);
            NSArray *arr = [self.imageDate valueForKey:@"small"];
            self.imageH = [dict valueForKey:@"height"];
            self.imageW = [dict valueForKey:@"width"];
            NSString *str = [arr objectAtIndex:path.item];

            
            //            NSString *strH = [self.imageH objectAtIndex:path.item];
//            NSString *strW = [self.imageW objectAtIndex:path.item];
  //          self.infNumber = self.infNumber + 1;
            [self loadImagesInItems:cell withString:str atIndexPath:path];
            
           

        }
    }];
    [task resume];
    [componets autorelease];

    
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//   // [self.imageStockView reloadData];
//    self.infNumber = self.infNumber + 1;
//
//}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"ended");
    //self.infNumber = self.infNumber + 1
    [self.imageStockView reloadData];
     self.infNumber = self.infNumber + 6;
}

-(void)loadImagesInItems:(ImageStockCell*)cell withString:(NSString*)str atIndexPath:(NSIndexPath*)path{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData *dat = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: str]];
        NSString *strH = [self.imageH objectAtIndex:path.item];
        NSString *strW = [self.imageW objectAtIndex:path.item];
        if (!dat){
            
            NSLog(@"Loading...");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cell.tag == path.item){
            cell.width = [strW intValue];
            cell.height = [strH intValue];
            //                CGSize size = cell.stockImageView.frame.size;
            //               NSLog(@"size %f: ", cell.height / 3);
            cell.stockImageView.image = [UIImage imageWithData: dat];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData: dat]];
            //self.infNumber = self.infNumber + 4;
            [cell.stockImageView setNeedsLayout];
            
            
             }
        });
        
    });
}
-(void)getJson{
    NSString *client_id = @"b132b205e5222fb070766e967d5ce4a97019704f212a35b7db5c249131967858";
    //@"b3b44601b00c840945f3c415f24e043ee5149121d2de04e4b47cb290b3401b2c";
    //b132b205e5222fb070766e967d5ce4a97019704f212a35b7db5c249131967858
    
    NSURLComponents *componets = [NSURLComponents new];
    componets.scheme = @"https";
    componets.host = @"api.unsplash.com";
    componets.path = @"/photos/random";
    componets.queryItems = @[
                             [NSURLQueryItem queryItemWithName:@"client_id" value: client_id],
                             //[NSURLQueryItem queryItemWithName:@"page" value: [@(10) stringValue]],
                             //[NSURLQueryItem queryItemWithName:@"per_page" value: [@(10) stringValue]]
                             [NSURLQueryItem queryItemWithName:@"count" value: @"30"]
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
        
        if (data != nil)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            self.imageDate = [dict valueForKey:@"urls"];
            //[self.mutableImageDate addEntriesFromDictionary:dict];
            //  NSLog(@"%lu", (unsigned long)dict.count);
            //NSArray *arr = [self.imageDate valueForKey:@"small"];
            self.imageH = [dict valueForKey:@"height"];
            self.imageW = [dict valueForKey:@"width"];
            
            
            //            NSString *strH = [self.imageH objectAtIndex:path.item];
            //            NSString *strW = [self.imageW objectAtIndex:path.item];
            // self.infNumber = self.infNumber + 1;
        }
    }];
    [task resume];
    [componets autorelease];
    
}
@end
