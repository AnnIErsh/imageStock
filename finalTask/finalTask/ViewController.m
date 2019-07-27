//
//  ViewController.m
//  finalTask
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.borderWidth = 10;
    
    
    self.imageView  = [[UIImageView alloc] initWithFrame:self.view.bounds];
    if (self.image.size.width > self.view.bounds.size.width || self.image.size.height > self.view.bounds.size.height) {
        self.imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        self.imageView.image = self.image;
        
        
    }
    else {
        self.imageView.image = self.image;
    }
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view reloadInputViews];
    [self.view addSubview:self.imageView];
    

}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.view reloadInputViews];
    self.imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin;;
}




@end

