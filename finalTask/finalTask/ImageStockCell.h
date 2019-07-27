//
//  ImageStockCell.h
//  finalTask
//
//  Created by Anna Ershova on 7/25/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageStockCell : UICollectionViewCell
@property (retain,nonatomic) UIImageView *stockImageView;
+ (instancetype)sizingCell;
@property (assign) CGFloat height;
@property (assign) CGFloat width;
@end


