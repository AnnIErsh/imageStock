//
//  CachingImage.h
//  finalTask
//
//  Created by Anna Ershova on 7/27/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface CachingImage : NSObject
@property (nonatomic, strong) NSCache *imageCache;
+ (CachingImage*)sharedInstance;

- (void)cacheImage:(UIImage*)image forKey:(NSString*)key;
- (UIImage*)getCachedImageForKey:(NSString*)key;
@end
