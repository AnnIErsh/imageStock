//
//  AppDelegate.h
//  finalTask
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;

@property (readonly, retain) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

