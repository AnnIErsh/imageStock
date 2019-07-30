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
@property (retain,nonatomic) __block NSString *idImage;
@property (retain,nonatomic) __block NSString *altDescription;
@property (retain,nonatomic) __block NSString *urBigImage;
@end


