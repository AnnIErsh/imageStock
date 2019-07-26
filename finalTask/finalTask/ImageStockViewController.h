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
@end


