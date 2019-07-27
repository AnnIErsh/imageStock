//
//  ImageStockCell.m
//  finalTask
//
//  Created by Anna Ershova on 7/25/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ImageStockCell.h"

@implementation ImageStockCell

+ (instancetype)sizingCell {
    static id sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self new];
    });
    return sizingCell;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.height;
        //self.width;
        self.stockImageView = [[UIImageView new]autorelease];
        self.stockImageView.frame = CGRectMake(self.viewForLastBaselineLayout.frame.size.width / 2 - 90, self.viewForLastBaselineLayout.frame.size.height / 2 - 90, 180, 180);
        [self.viewForLastBaselineLayout addSubview:self.stockImageView];
       // self.viewForLastBaselineLayout.layer.masksToBounds = YES;
        self.viewForLastBaselineLayout.layer.cornerRadius = 8.0f;
        self.stockImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.stockImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}


@end
