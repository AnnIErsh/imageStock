//
//  FilterCollectionViewCell.m
//  finalTask
//
//  Created by Anna Ershova on 7/28/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "FilterCollectionViewCell.h"

@implementation FilterCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.height;
        //self.width;
        self.filterImage = [[UIImage new] autorelease];
        self.filterImageView = [[UIImageView new]autorelease];
        //[self.filterImageView setImage:self.filterImage];
        [self.filterImageView setFrame:self.bounds];
        [self addSubview: self.filterImageView];
     //   self.viewForLastBaselineLayout.layer.masksToBounds = YES;
        self.viewForLastBaselineLayout.layer.cornerRadius = 8.0f;
        self.filterImageView.contentMode = UIViewContentModeScaleAspectFit;
        //self.backgroundView = self.filterImage;
//        self.filterImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}



@end
