//
//  ViewController.m
//  finalTask
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ViewController.h"
#import "FilterCollectionViewCell.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //  self.view.layer.borderWidth = 10;
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
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(pinchGestureDetected:)];
    pinch.delegate = self;
    [self.imageView addGestureRecognizer:pinch];
    
    [self setButton];
    [self addSaveButton];
    [self setFilterView];
    [self setAutoresizing];
    self.filtersCollection.hidden = YES;
    
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self reloadInputViews];
    [self setAutoresizing];
    
}

-(void)setAutoresizing{
    [self.buttonToGallery setFrame:CGRectMake(5*self.view.bounds.size.width/12, self.view.bounds.size.height - self.view.bounds.size.width/6, self.view.bounds.size.width/6, self.view.bounds.size.width/6)];
    self.buttonToGallery.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    
    if (self.image.size.width > self.view.bounds.size.width || self.image.size.height > self.view.bounds.size.height) {
        [self.imageView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    } else {
        self.imageView.center = self.view.superview.center;
    }
    
    //self.imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.filtersCollection setFrame: CGRectMake(0, self.view.bounds.size.height - 205, self.view.bounds.size.width, 200)];
    self.filtersCollection.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FilterCollectionViewCell *cell = [self.filtersCollection dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
    
    //cell.filterImage = self.image;
    // UIImage *imageCell = [self imageWithFilter: self.image forIndex:indexPath.item];
    cell.backgroundView = [[UIImageView alloc] initWithImage: self.image];
    cell.backgroundView.layer.opacity = 0.7;
    cell.backgroundColor = [self setColor:(int)indexPath.item];
    cell.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.view.frame.size.height < self.view.frame.size.width){
        [self.buttonToGallery setFrame:CGRectMake(self.view.bounds.size.width/2 - self.view.bounds.size.height/12, self.view.bounds.size.height - self.view.bounds.size.height/6, self.view.bounds.size.height/6, self.view.bounds.size.height/6)];
        [self.view reloadInputViews];
        
        return CGSizeMake(self.view.bounds.size.height / 4, self.view.bounds.size.height / 4);
        
    }
    
    return CGSizeMake(self.view.bounds.size.width / 4, self.view.bounds.size.width / 4);
}


CGFloat initialX;
CGFloat initialY;

-(void)moving:(id)sender {
    [self.imageView bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint toPoint = [(UIPanGestureRecognizer*)sender translationInView:self.imageView];
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
//        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
//                                stringForKey:@"2TbuT26y3dc"];
//        NSLog(@"cheking: saved url %@", savedValue);
    }
    
}
- (void)pinchGestureDetected:(UIPinchGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
        [recognizer setScale:1.0];
    }
    
}



-(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToWidth:(float)width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = width / oldWidth;
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
    [self.buttonToGallery setFrame:CGRectMake(5*self.view.bounds.size.width/12, self.view.bounds.size.height - self.view.bounds.size.width/6, self.view.bounds.size.width/6, self.view.bounds.size.width/6)];
    self.buttonToGallery.titleLabel.font = [UIFont systemFontOfSize: 16];
    self.buttonToGallery.backgroundColor = UIColor.lightGrayColor;
    self.buttonToGallery.layer.opacity = 0.7;
    self.buttonToGallery.layer.cornerRadius = 20;
    [self.view addSubview:self.buttonToGallery];
    [self.buttonToGallery setTitle:@"open" forState:UIControlStateNormal];
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
    self.filtersCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 205, self.view.bounds.size.width, 200) collectionViewLayout:layout];
    [self.filtersCollection registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:@"FilterCell"];
    self.filtersCollection.delegate = self;
    self.filtersCollection.dataSource = self;
    [self.filtersCollection setBackgroundColor:[UIColor lightTextColor]];
    [self.view addSubview:self.filtersCollection];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
}

-(void)addSaveButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"SAVE" style:UIBarButtonItemStylePlain target:self action:@selector(saving:)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
}
- (void)saving:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self imageWithFilter:self.image forIndex:indexPath.item];
}
-(UIImage*)imageWithFilter:(UIImage*)inputImage forIndex:(long)index {
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
            return targetImage;
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
            return targetImage;
            
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
            return targetImage;
            
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
            return targetImage;
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
            return targetImage;
            
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
            return targetImage;
            
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
            return targetImage;
            
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
            return targetImage;
        }
            
            
            
        default:
            break;
    }
    return self.image;
}

-(UIColor*)setColor:(int)index{
    UIColor *color = [[UIColor new]autorelease];
    switch (index) {
        case 0:color = [UIColor colorWithRed:112/255.0 green:66/255.0 blue:20/255.0 alpha:1];break;
        case 1:color = [UIColor colorWithRed:62/255.0 green:48/255.0 blue:48/255.0 alpha:1.0];break;
        case 2:color = [UIColor colorWithRed:161/255.0 green:164/255.0 blue:167/255.0 alpha:1.0];break;
        case 3:color = [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1.0];break;
        case 4:color = [UIColor colorWithRed:183/255.0 green:222/255.0 blue:210/255.0 alpha:1.0];break;
        case 5:color = [UIColor colorWithRed:255/255.0 green:236/255.0 blue:184/255.0 alpha:1.0];break;
        case 6:color = [UIColor colorWithRed:150/255.0 green:164/255.0 blue:214/255.0 alpha:1.0];break;
        case 7:color = [UIColor colorWithRed:27/255.0 green:27/255.0 blue:27/255.0 alpha:1.0];break;
        default:
            break;
    }
    
    
    return color;
}

@end


