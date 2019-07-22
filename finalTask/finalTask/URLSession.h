//
//  URLSession.h
//  finalTask
//
//  Created by Anna Ershova on 7/21/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <Foundation/Foundation.h>

//b3b44601b00c840945f3c415f24e043ee5149121d2de04e4b47cb290b3401b2c

@interface URLSession : NSURLSession
@property (nonatomic,assign) int token;
@property (nonatomic,retain) NSString *userId;
@end


