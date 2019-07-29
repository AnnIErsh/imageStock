//
//  ViewController.h
//  finalTask
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (retain) UIImageView *imageView;
@property (retain) UICollectionView *filtersCollection;
@property (retain) UIImage *image;
@property (retain) UIButton *buttonToGallery;
@property (retain) UIBarButtonItem *saveButton;
@property (retain) NSArray *filters;


@end

