//
//  ViewController.m
//  finalTask
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ViewController.h"
#import "FilterCollectionViewCell.h"
#import "UIImage+Filters.h"
#import "CIImage+Filters.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
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
    self.imageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moving:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate: self];
    [self.imageView addGestureRecognizer:panRecognizer];
    
    [self setButton];
    [self addSaveButton];
    [self setFilterView];
    self.filtersCollection.hidden = YES;
//    [self setFilterView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBegan:withEvent:)];
//    [self.imageView addGestureRecognizer:tap];
    

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FilterCollectionViewCell *cell = [self.filtersCollection dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
    //cell.backgroundColor = UIColor.greenColor;
   // cell.filterImage = self.image;
    //cell.filterImageView.image = self.image;
    //cell.filterImage = self.image;
   // [cell.filterImageView setImage:self.image];
    //cell.filterImageView.layer.borderWidth = 2;
    //cell.filterImageView.layer.borderWidth = 2;
    cell.backgroundView = [[UIImageView alloc] initWithImage: self.image];
    return cell;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 80);
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   // [self.view reloadInputViews];
    [self reloadInputViews];
//    [self.view setNeedsDisplay];
//  //  [self.view setNeedsLayout];
//    self.imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin;
//    [self.buttonToGallery setFrame:CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height - 150, 200, 100)];
//    self.buttonToGallery.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleLeftMargin;
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout new] autorelease];
 
   // [self setButton];
    
}
//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//}

CGFloat initialX;
CGFloat initialY;

-(void)moving:(id)sender {
    [self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint toPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        initialX = [[sender view] center].x;
        initialY = [[sender view] center].y;
    }
    toPoint = CGPointMake(initialX+toPoint.x, initialY+toPoint.y);
    [[sender view] setCenter:toPoint];
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        CGFloat currentX = toPoint.x + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.imageView].x);
        CGFloat currentY = toPoint.y + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.imageView].y);
        [[sender view] setCenter:CGPointMake(currentX, currentY)];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[[event allTouches] allObjects] objectAtIndex:0];
    if ([touch.view isEqual: self.imageView]) {
        self.filtersCollection.hidden = YES;
        self.buttonToGallery.hidden = NO;
    } else {
    
    }

}



-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



-(void)setButton{
    self.buttonToGallery = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.buttonToGallery setFrame:CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height - 150, 200, 100)];
    self.buttonToGallery.titleLabel.font = [UIFont systemFontOfSize: 20];
    self.buttonToGallery.backgroundColor = UIColor.darkGrayColor;
    [self.view.viewForLastBaselineLayout addSubview:self.buttonToGallery];
    [self.buttonToGallery setTitle:@"Open Me" forState:UIControlStateNormal];
  //  [self.buttonToGallery setTitle:@"I'm closed!" forState:UIControlStateSelected];
    self.buttonToGallery.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleLeftMargin;
    
    [self.buttonToGallery addTarget:self action:@selector(setButtonPress:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.buttonToGallery];
}

-(void)setButtonPress:(UIButton*)sender {
   // [self setFilterView];
    if (sender.selected == YES) {
       // [self setFilterView];
        self.filtersCollection.hidden = NO;
        self.buttonToGallery.hidden = YES;
        sender.selected = NO;
    }else{
        sender.selected = YES;
    
    }
//    UIImagePickerController *picker = [[UIImagePickerController new] autorelease];
//    picker.delegate = self;
//    [picker setSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
//    [self presentViewController: picker animated:YES completion:nil];

}

-(void)setFilterView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout new] autorelease];
    self.filtersCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 110, self.view.frame.size.width, 100) collectionViewLayout:layout];
    //CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 100) collectionViewLayout:layout];
    [self.filtersCollection registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:@"FilterCell"];
    self.filtersCollection.delegate = self;
    self.filtersCollection.dataSource = self;
    self.filtersCollection.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self.filtersCollection setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.filtersCollection];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
}

-(void)addSaveButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"SAVE" style:UIBarButtonItemStylePlain target:self action:@selector(saving:)];
    [self.navigationItem setLeftBarButtonItem:item animated:YES];
}
- (void)saving:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self imageWithFilter:self.image forIndex:indexPath.item];
}
-(void)imageWithFilter: (UIImage*)inputImage forIndex:(long)index {
    switch (index) {
        case 0: {
            CIContext *imageContext = [CIContext contextWithOptions:nil];
            CIImage *image = [[CIImage alloc] initWithImage:inputImage];
            CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                          keysAndValues: kCIInputImageKey, image,
                                @"inputIntensity", @1, nil];
            CIImage *result = [filter valueForKey: @"outputImage"];
            CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
            UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
            [self.imageView setImage:targetImage];
            break;
        }
        case 1:
        {
            
            CIContext *imageContext = [CIContext contextWithOptions:nil];
            CIImage *image = [[CIImage alloc] initWithImage:inputImage];
            
            CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
            [vignette setDefaults];
            [vignette setValue: image forKey: @"inputImage"];
            [vignette setValue: [NSNumber numberWithFloat: 1.0] forKey: @"inputIntensity"];
            [vignette setValue: [NSNumber numberWithFloat: 10.00 ] forKey: @"inputRadius"];
            CIImage *result = [vignette valueForKey: @"outputImage"];
            CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
            UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
            [self.imageView setImage:targetImage];
            
            break;
            
        }
        case 2:
        {
            
            CIContext *imageContext = [CIContext contextWithOptions:nil];
            CIImage *image = [[CIImage alloc] initWithImage:inputImage];
            CIFilter *filter= [CIFilter filterWithName:@"CIPhotoEffectTonal"];
            [filter setValue:image forKey:@"inputImage"];
            CIImage *result = [filter valueForKey: @"outputImage"];
            CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
            UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
            [self.imageView setImage:targetImage];
            break;
            
        }
        case 3:{
        
            CIContext *imageContext = [CIContext contextWithOptions:nil];
            CIImage *image = [[CIImage alloc] initWithImage:inputImage];
            CIFilter *filter= [CIFilter filterWithName:@"CIColorControls"];
            [filter setValue:image forKey:@"inputImage"];
            [filter setValue:[NSNumber numberWithFloat:0] forKey:@"inputSaturation"];
            [filter setValue:[NSNumber numberWithFloat:1.05] forKey:@"inputContrast"];
            CIImage *result = [filter valueForKey: @"outputImage"];
            CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
            UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
            [self.imageView setImage:targetImage];
            
            break;
        }
        case 4:
        {
            CIContext *imageContext = [CIContext contextWithOptions:nil];
            CIImage *image = [[CIImage alloc] initWithImage:inputImage];
            CIFilter *filter= [CIFilter filterWithName:@"CIPhotoEffectProcess"];
            [filter setValue:image forKey:@"inputImage"];
            CIImage *result = [filter valueForKey: @"outputImage"];
            CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
            UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
            [self.imageView setImage:targetImage];
            break;
            
        }
        case 5:
        {
            CIContext *imageContext = [CIContext contextWithOptions:nil];
            CIImage *image = [[CIImage alloc] initWithImage:inputImage];
            CIFilter *filter= [CIFilter filterWithName:@"CIPhotoEffectTransfer"];
            [filter setValue:image forKey:@"inputImage"];
            CIImage *result = [filter valueForKey: @"outputImage"];
            CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
            UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
            [self.imageView setImage:targetImage];
            break;
            
        }
        case 6:
        {
            CIContext *imageContext = [CIContext contextWithOptions:nil];
            CIImage *image = [[CIImage alloc] initWithImage:inputImage];
            CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues: kCIInputImageKey,image,@"inputColor",[CIColor colorWithRed:0.5 green:0.5 blue:1.0],@"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
            CIImage *result = [filter valueForKey: @"outputImage"];
            CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
            UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
            [self.imageView setImage:targetImage];
            break;
            
        }
        case 7:
        {
            CIContext *imageContext = [CIContext contextWithOptions:nil];
            CIImage *image = [[CIImage alloc] initWithImage:inputImage];
            CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues: kCIInputImageKey,image, nil];
            CIImage *result = [filter valueForKey: @"outputImage"];
            CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
            UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
            [self.imageView setImage:targetImage];
            break;
        }
            
            
            
        default:
            break;
    }
}

@end


