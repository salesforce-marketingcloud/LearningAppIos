/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "AppDelegate+MarketingCloudSDK.h"

#import <UserNotifications/UserNotifications.h>

@implementation AppDelegate (MarketingCloudSDK)
#pragma mark - SDK Setup
- (BOOL)application:(UIApplication *)application shouldInitMarketingCloudSDKWithOptions:(NSDictionary *)launchOptions {
    
    // weak reference to avoid retain cycle within block
    __weak __typeof__(self) weakSelf = self;
    
    NSError *configureError = nil;
    
    NSURL *configurationFileURL = [[NSBundle mainBundle] URLForResource:@"MarketingCloudSDKConfiguration" withExtension:@"json"];
    NSInteger configIndex = 0; // index of production configuration in the JSON file dictionary
#ifdef DEBUG
    configIndex = 1;    // index of development/debug configuration
#endif
    BOOL configured = [[MarketingCloudSDK sharedInstance] sfmc_configureWithURL:configurationFileURL configurationIndex:@(configIndex) error:&configureError
                                                              completionHandler:^(BOOL success, NSString *appId, NSError *error) {        // The SDK has been fully configured and is ready for use!
                                                                  if (success == NO) {
                                                                      UIAlertController *theAlertController = [UIAlertController
                                                                                                               alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                                                                               message:error ? error.localizedDescription : NSLocalizedString(@"An error occurred calling configure", nil)
                                                                                                            preferredStyle:UIAlertControllerStyleAlert];
                                                                      
                                                                      UIAlertAction *okAction = [UIAlertAction
                                                                                                 actionWithTitle:NSLocalizedString(@"OK", nil)
                                                                                                 style:UIAlertActionStyleDefault
                                                                                                 handler:nil];
                                                                      [theAlertController addAction:okAction];
                                                                      
                                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                                          [[weakSelf topMostController] presentViewController:theAlertController animated:YES completion:^{}];
                                                                          });
                                                                  }
        // set the delegate if needed then ask if we are authorized - the delegate must be set here if used
        [UNUserNotificationCenter currentNotificationCenter].delegate = weakSelf;

        dispatch_async(dispatch_get_main_queue(), ^{
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
           if (error == nil) {
               if (granted == YES) {
                   os_log_info(OS_LOG_DEFAULT, "Authorized for notifications = %s", granted ? "YES" : "NO");
                   
                   // we are authorized to use notifications, request a device token for remote notifications
                   dispatch_async(dispatch_get_main_queue(), ^{
                       [[UIApplication sharedApplication] registerForRemoteNotifications];
                   });
                   /**
                    Start geoLocation
                    */
                   [[MarketingCloudSDK sharedInstance] sfmc_startWatchingLocation];
                   
                   [[MarketingCloudSDK sharedInstance] sfmc_trackPageViewWithURL:@"data://SDKInitializationCompletedSuccessfully" title:@"SDK Initialization Completed" item:nil search:nil];
                   // set an attribute called 'MyBooleanAttribute' with value '0'
                   [[MarketingCloudSDK sharedInstance] sfmc_setAttributeNamed:@"MyBooleanAttribute" value:@"0"];
                   
                   /*
                    Example of using the getSDKState Method for rapidly debugging issues
                    */
                   [[MarketingCloudSDK sharedInstance] sfmc_getSDKState];
                   
                   [[MarketingCloudSDK sharedInstance] sfmc_setInboxMessagesNotificationHandlerDelegate:self];
               }
           }
       }];
        });
    }];
    if (configured == YES) {
        // The configuation process is underway.
    }
    else {                                                                     UIAlertController *theAlertController = [UIAlertController
                                                                                                                        alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                                                                                        message:NSLocalizedString(@"An error occurred calling configure", nil)
                                                                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", nil)
                               style:UIAlertActionStyleDefault
                               handler:nil];
    [theAlertController addAction:okAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self topMostController] presentViewController:theAlertController animated:YES completion:^{}];
    });
}

    
//#ifdef DEBUG
//    /**
//     To enable Debug Log set to YES
//     */
//    [ETPush setETLoggerToRequiredState:YES];
//
//    successful = [[MarketingCloudSDK sharedInstance] configureSDKWithAppID:kETAppID_Debug                // Configure the SDK with the Debug App ID
//                                              andAccessToken:kETAccessToken_Debug        // Configure the SDK with the Debug Access Token
//                                               withAnalytics:YES                        // Enable Analytics
//                                         andLocationServices:YES                        // Enable Location Services (Geofence Messaging)
//                                        andProximityServices:YES                        // Enable Proximity services (Beacon Messaging)
//                                               andCloudPages:YES                        // Enable Cloud Pages
//                                             withPIAnalytics:YES                        // Enable WAMA / PI Analytics
//                                                       error:&error];
//
//#else
//    /**
//     Configure and set initial settings of the JB4ASDK when in PRODUCTION mode
//     */
//    successful = [[MarketingCloudSDK sharedInstance] configureSDKWithAppID:kETAppID_Prod                // Configure the SDK with the Debug App ID
//                                              andAccessToken:kETAccessToken_Prod        // Configure the SDK with the Debug Access Token
//                                               withAnalytics:YES                        // Enable Analytics
//                                         andLocationServices:YES                        // Enable Location Services (Geofence Messaging)
//                                        andProximityServices:YES                        // Enable Proximity services (Beacon Messaging)
//                                               andCloudPages:YES                        // Enable Cloud Pages
//                                             withPIAnalytics:YES                        // Enable WAMA / PI Analytics
//                                                       error:&error];
//#endif
//    /**
//     If configureSDKWithAppID returns NO, check the error object for detailed failure info. See PushConstants.h for codes.
//     The features of the JB4ASDK will NOT be useable unless configureSDKWithAppID returns YES.
//     */
//    if (!successful) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            /**
//             Something has failed in the configureSDKWithAppID call - show error message
//             Because this only occurs when an error has occured, and because UIAlertView
//             is deprecated in iOS 9+, but we're backwards compatible these pragma marks
//             disable deprecation warnings for UIAlertView.
//             */
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed configureSDKWithAppID!", @"Failed configureSDKWithAppID!")
//                                        message:[error localizedDescription]
//                                       delegate:nil
//                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
//                              otherButtonTitles:nil] show];
//#pragma clang diagnostic pop
//
//        });
//
//        [ETAnalytics trackPageView:@"data://SDKInitializationFailed" andTitle:[error localizedDescription] andItem:nil andSearch:nil];
//
//    } else {
//        /**
//         Register for push notifications - enable all notification types, no categories
//         */
//        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_9_x_Max) {
//            [[MarketingCloudSDK sharedInstance] registerForRemoteNotificationsWithDelegate:self options:(UNAuthorizationOptionAlert + UNAuthorizationOptionBadge + UNAuthorizationOptionSound) categories:nil completionHandler:^(BOOL granted, NSError * _Nullable error) {
//
//                NSLog(@"Registered for remote notifications: %d", granted);
//
//            }];
//        }
//        else {
//            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
//                                                    UIUserNotificationTypeBadge |
//                                                    UIUserNotificationTypeSound |
//                                                    UIUserNotificationTypeAlert
//                                                                                     categories:nil];
//            // Notify the SDK what user notification settings have been selected
//            [[MarketingCloudSDK sharedInstance] registerUserNotificationSettings:settings];
//            [[MarketingCloudSDK sharedInstance] registerForRemoteNotifications];
//        }
//
//    
//    }
    
    return YES;
}

#pragma mark - Lifecycle Callbacks

// The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    if (completionHandler != nil) {
        completionHandler(UNNotificationPresentationOptionAlert);
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[MarketingCloudSDK sharedInstance] sfmc_setDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    os_log_debug(OS_LOG_DEFAULT, "didFailToRegisterForRemoteNotificationsWithError = %@", error);
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
    // tell the MarketingCloudSDK about the notification
    [[MarketingCloudSDK sharedInstance] sfmc_setNotificationRequest:response.notification.request];
    
    if (completionHandler != nil) {
        completionHandler();
    }
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.userInfo = userInfo;
    UNNotificationRequest *silentPushRequest = [UNNotificationRequest requestWithIdentifier:[NSUUID UUID].UUIDString content:content trigger:nil];
    
    [[MarketingCloudSDK sharedInstance] sfmc_setNotificationRequest:silentPushRequest];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark Cloud Page delegates
- (void)sfmc_didReceiveInboxMessagesNotificationWithContents:(NSDictionary *)inboxMessage {
    
    NSString *urlString = [inboxMessage objectForKey:MarketingCloudSDKInboxMessageKey];
    if (urlString != nil) {
        // use the url in any way you'd like
        NSLog(@"%@", urlString);
    }
}

- (UIViewController*) topMostController {
    UITabBarController *topController = (UITabBarController *)self.window.rootViewController;
    UIViewController *topViewController = [topController viewControllers].firstObject;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    
    return topViewController;
}

@end
