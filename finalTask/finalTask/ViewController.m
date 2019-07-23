//
//  ViewController.m
//  finalTask
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ViewController.h"
#import "URLSession.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *client_id = @"b3b44601b00c840945f3c415f24e043ee5149121d2de04e4b47cb290b3401b2c";
    NSURLComponents *componets = [NSURLComponents new];
    componets.scheme = @"https";
    componets.host = @"api.unsplash.com";
    componets.path = @"/photos/random";
    componets.queryItems = @[
                             [NSURLQueryItem queryItemWithName:@"client_id" value: client_id],
                             [NSURLQueryItem queryItemWithName:@"count" value: @"10"]
                             ];
    NSURL *url = componets.URL;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error)
        {
            NSLog(@"Error : %@\n", error);
            return;
        }
        
        if (data != nil)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"Response :\n%@\n", dict);
            NSLog(@"%lu", (unsigned long)dict.count);
        }
        
        
    }];
    [task resume];
    [componets autorelease];
    
}


@end

