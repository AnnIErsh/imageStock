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
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout new] autorelease];
    self.imageStockView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.imageStockView setDataSource:self];
    [self.imageStockView setDelegate:self];
    [self.imageStockView registerClass:[ImageStockCell class] forCellWithReuseIdentifier:@"CellStock"];
    [self.imageStockView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.imageStockView];
  
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(200,200);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageStockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellStock" forIndexPath:indexPath];
    int i = (arc4random() % 1000) + 1;
    NSString *sValue = [@(i) stringValue];
    [self fetchRequest:cell forOndexPath:indexPath withPage:sValue];
    return cell;
}


- (void)fetchRequest: (ImageStockCell *)cell forOndexPath: (NSIndexPath*)path withPage:(NSString*)page{
    NSString *client_id = @"b3b44601b00c840945f3c415f24e043ee5149121d2de04e4b47cb290b3401b2c";
    //@"b3b44601b00c840945f3c415f24e043ee5149121d2de04e4b47cb290b3401b2c";
    //b132b205e5222fb070766e967d5ce4a97019704f212a35b7db5c249131967858
    NSURLComponents *componets = [NSURLComponents new];
    componets.scheme = @"https";
    componets.host = @"api.unsplash.com";
    componets.path = @"/photos";
    componets.queryItems = @[
                             [NSURLQueryItem queryItemWithName:@"client_id" value: client_id],
                             [NSURLQueryItem queryItemWithName:@"page" value: page],
                             [NSURLQueryItem queryItemWithName:@"per_page" value: @"5"]
                             //[NSURLQueryItem queryItemWithName:@"count" value: @"5"]
                             ];
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
            NSLog(@"%lu", (unsigned long)dict.count);
           
            NSArray *arr = [self.imageDate valueForKey:@"full"];
            NSString *str = [arr objectAtIndex:path.item];

            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData *dat = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: str]];
                if ( dat == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //cell.stockImageView.image = [UIImage imageWithData: dat];
                    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData: dat]];
                });

            });
        }
    }];
    [task resume];
    [componets autorelease];
    
}



@end
