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
@property (retain) __block NSString *idImage;
@property (retain) __block NSString *altDescription;
@property (retain) __block NSString *urBigImage;
@end


