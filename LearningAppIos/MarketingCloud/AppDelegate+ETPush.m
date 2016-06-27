/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "AppDelegate+ETPush.h"
#import "ETPush.h"
#import "AppDelegate+ETPushConstants.h"
#import "ETAnalytics.h"
#import "ETRegion.h"
#import "ETWKLandingPagePresenter.h"

@implementation AppDelegate (ETPush)
#pragma mark - SDK Setup
- (BOOL)application:(UIApplication *)application shouldInitETSDKWithOptions:(NSDictionary *)launchOptions {
    BOOL successful = NO;
    NSError *error = nil;
    
    [[ETPush pushManager] setCloudPageWithAlertDelegate:self];
    
#ifdef DEBUG
    /**
     To enable Debug Log set to YES
     */
    [ETPush setETLoggerToRequiredState:YES];
    
    successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Debug				// Configure the SDK with the Debug App ID
                                              andAccessToken:kETAccessToken_Debug		// Configure the SDK with the Debug Access Token
                                               withAnalytics:YES						// Enable Analytics
                                         andLocationServices:YES                        // Enable Location Services (Geofence Messaging)
                                        andProximityServices:YES						// Enable Proximity services (Beacon Messaging)
                                               andCloudPages:YES						// Enable Cloud Pages
                                             withPIAnalytics:YES						// Enable WAMA / PI Analytics
                                                       error:&error];
    
#else
    /**
     Configure and set initial settings of the JB4ASDK when in PRODUCTION mode
     */
    successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Prod				// Configure the SDK with the Debug App ID
                                              andAccessToken:kETAccessToken_Prod		// Configure the SDK with the Debug Access Token
                                               withAnalytics:YES						// Enable Analytics
                                         andLocationServices:YES						// Enable Location Services (Geofence Messaging)
                                        andProximityServices:YES						// Enable Proximity services (Beacon Messaging)
                                               andCloudPages:YES						// Enable Cloud Pages
                                             withPIAnalytics:YES						// Enable WAMA / PI Analytics
                                                       error:&error];
#endif
    /**
     If configureSDKWithAppID returns NO, check the error object for detailed failure info. See PushConstants.h for codes.
     The features of the JB4ASDK will NOT be useable unless configureSDKWithAppID returns YES.
     */
    if (!successful) {
        dispatch_async(dispatch_get_main_queue(), ^{
            /**
             Something has failed in the configureSDKWithAppID call - show error message
             Because this only occurs when an error has occured, and because UIAlertView
             is deprecated in iOS 9+, but we're backwards compatible these pragma marks
             disable deprecation warnings for UIAlertView.
             */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed configureSDKWithAppID!", @"Failed configureSDKWithAppID!")
                                        message:[error localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                              otherButtonTitles:nil] show];
#pragma clang diagnostic pop
            
        });
        
        [ETAnalytics trackPageView:@"data://SDKInitializationFailed" andTitle:[error localizedDescription] andItem:nil andSearch:nil];
        
    } else {
        /**
         Register for push notifications - enable all notification types, no categories
         */
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound |
                                                UIUserNotificationTypeAlert
                                                                                 categories:nil];
        // Notify the SDK what user notification settings have been selected
        [[ETPush pushManager] registerUserNotificationSettings:settings];
        [[ETPush pushManager] registerForRemoteNotifications];
        
        /**
         Start geoLocation
         */
        [[ETLocationManager sharedInstance] startWatchingLocation];
        
        /**
         Begins fence retrieval from ET of Geofences.
         */
        [ETRegion retrieveGeofencesFromET];
        
        /**
         Begins fence retrieval from ET of Beacons.
         */
        [ETRegion retrieveProximityFromET];
        
        /**
         Inform the JB4ASDK of the launch options - possibly UIApplicationLaunchOptionsRemoteNotificationKey or UIApplicationLaunchOptionsLocalNotificationKey
         */
        [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
        
        [ETAnalytics trackPageView:@"data://SDKInitializationCompletedSuccessfully" andTitle:@"SDK Initialization Completed" andItem:nil andSearch:nil];
        // set an attribute called 'MyBooleanAttribute' with value '0'
        [[ETPush pushManager] addAttributeNamed:@"MyBooleanAttribute" value:@"0"];
        
        /*
         Example of using the getSDKState Method for rapidly debugging issues
         */
        [ETPush getSDKState];
        
    }
    
    return YES;
}

- (void)didReceiveCloudPageWithAlertMessageWithContents:(NSString *)payload {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[ETWKLandingPagePresenter alloc] initForLandingPageAt:payload]
                                                                                 animated:YES
                                                                               completion:nil];
}

-(BOOL)shouldDeliverCloudPageWithAlertMessageIfAppIsRunning
{
    return YES;
}

#pragma mark - Lifecycle Callbacks
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    /**
     Inform the JB4ASDK of the requested notification settings
     */
    [[ETPush pushManager] didRegisterUserNotificationSettings:notificationSettings];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /**
     Inform the JB4ASDK of the device token
     */
    [[ETPush pushManager] registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    /**
     Inform the JB4ASDK that the device failed to register and did not receive a device token
     */
    [[ETPush pushManager] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
    [ETAnalytics trackPageView:@"data://applicationDidFailToRegisterForRemoteNotificationsWithError" andTitle:[error localizedDescription] andItem:nil andSearch:nil];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /**
     Use this method to disable Location Services through the MobilePush SDK.
     */
    [[ETLocationManager sharedInstance]startWatchingLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /**
     Use this method to initiate Location Services through the MobilePush SDK.
     */
    [[ETLocationManager sharedInstance]stopWatchingLocation];
}

#pragma mark - Message Received Callbacks
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     Inform the JB4ASDK that the device received a local notification
     */
    NSLog(@"Local Notification Receieved");
    [[ETPush pushManager] handleLocalNotification:notification];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Push Notification Received");
    [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler {
    /**
     Inform the JB4ASDK that the device received a remote notification
     */
    [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
    
    /**
     Is it a silent push?
     */
    if (userInfo[@"aps"][@"content-available"]) {
        /**
         Received a silent remote notification...
         Indicate a silent push
         */
        NSLog(@"Silent Push Notification Received");
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    } else {
        /**
         Received a remote notification...
         Clear the badge
         */
        [[ETPush pushManager] resetBadgeCount];
    }
    
    handler(UIBackgroundFetchResultNoData);
}

@end
