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
        self.stockImageView.frame = CGRectMake(0, 0, 100, 100);
        [self.viewForLastBaselineLayout addSubview:self.stockImageView];
       // self.viewForLastBaselineLayout.layer.masksToBounds = YES;
        self.viewForLastBaselineLayout.layer.cornerRadius = 8.0f;
    }
    return self;
}
@end
