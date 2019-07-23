//
//  URLSession.m
//  finalTask
//
//  Created by Anna Ershova on 7/21/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "URLSession.h"

@implementation URLSession
+ (instancetype)sharedInstance
{
    static URLSession *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[URLSession alloc] init];
    });
    return sharedInstance;
}
+ (id)allocWithZone:(NSZone *)zone
{
    static URLSession *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
        
    });
    return sharedInstance;
}
- (id)init {
    if (self = [super init]) {
        self.token = [[NSString alloc] initWithString:@""];
    }
    return self;
}


@end
