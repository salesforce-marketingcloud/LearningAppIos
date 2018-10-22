/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "AppDelegate.h"
#import "AppDelegate+MarketingCloudSDK.h"
#import <MarketingCloudSDK/MarketingCloudSDK.h>

@implementation AppDelegate

// DO NOT COPY AND PASTE THIS DIRECTLY INTO YOUR APP DELEGATE.M FILE.
// YOUR APPDELEGATE.M FILE ALREADY CONTAINS THIS METHOD, YOU
// ONLY NEED TO ADD THE CALL to the shouldInitMarketingCloudSDKWithOptions method below
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // This line is a required addition to your AppDelegate.m's method of the same name.
    // it is responsible for the initialization of the SDK from our category.
    [self application:application shouldInitMarketingCloudSDKWithOptions:launchOptions];
	
    return YES;
}




@end
