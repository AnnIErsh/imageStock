//
//  ViewController.h
//  finalTask
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomView;
@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (retain, nonatomic) __block NSDictionary *imageDate;
@property (retain, nonatomic) CustomView *image;
@property (retain, nonatomic) UIScrollView *scrollView;

@end

