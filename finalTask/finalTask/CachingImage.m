//
//  CachingImage.m
//  finalTask
//
//  Created by Anna Ershova on 7/27/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "CachingImage.h"
#import <UIKit/UIKit.h>

static CachingImage *sharedInstance;

@implementation CachingImage

+ (CachingImage*)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CachingImage alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)cacheImage:(UIImage*)image forKey:(NSString*)key {
    [self.imageCache setObject:image forKey:key];
}

- (UIImage*)getCachedImageForKey:(NSString*)key {
    return [self.imageCache objectForKey:key];
}

@end
