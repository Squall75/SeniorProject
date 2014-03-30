//
//  AppDelegate.h
//  DixonNav
//
//  Created by Todd Seabrook on 1/25/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void) buildDatabase; // This method should only be used once to fill the store.data file

-(NSArray*)readFile;


@end
