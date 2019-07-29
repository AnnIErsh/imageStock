//
//  ImageStockViewController.h
//  finalTask
//
//  Created by Anna Ershova on 7/25/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ImageStockViewController : UIViewController
@property (retain) UICollectionView *imageStockView;
@property (assign) int infNumber;
@property (assign) int moreNumber;
@property (retain, nonatomic) __block NSDictionary *imageDate;
@property (retain, nonatomic) __block NSMutableDictionary *mutableImageDate;
@property (retain, nonatomic) __block UIImage *imageToCache;
@property (retain, nonatomic) __block NSArray *imageH;
@property (retain, nonatomic) __block NSArray *imageW;
@property (retain, nonatomic) __block NSArray *imageArray;
@end


