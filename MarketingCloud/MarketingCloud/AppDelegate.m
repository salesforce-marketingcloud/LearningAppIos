//
//  AppDelegate.m
//  MarketingCloud
//
//  Created by Mathias on 10/8/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+ETPush.h"
@implementation AppDelegate

// DO NOT COPY AND PASTE THIS DIRECTLY INTO YOUR APP DELEGATE.M FILE.
// YOUR APPDELEGATE.M FILE ALREADY CONTAINS THIS METHOD, YOU
// ONLY NEED TO ADD THE CALL to the shouldInitETSDKWithOptions method below
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // This line is a required addition to your AppDelegate.m's method of the same name.
    // it is responsible for the initialization of the SDK from our category.
    [self application:application shouldInitETSDKWithOptions:launchOptions];
    
    return YES;
}

@end
