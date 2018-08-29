/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "AppDelegate+MarketingCloudSDK.h"
#import <MarketingCloudSDK/MarketingCloudSDK.h>
#import <SafariServices/SafariServices.h>

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
                                                                  else {
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
                                                                                      
                                                                                      [[MarketingCloudSDK sharedInstance] sfmc_setURLHandlingDelegate:self];
                                                                                      
                                                                                      [weakSelf testUserNotificationHandler];
                                                                                  }
                                                                              }
                                                                          }];
                                                                      });
                                                                  }
                                                              }];
    if (configured == YES) {
        // The configuation process is underway.
    }
    else {
        UIAlertController *theAlertController = [UIAlertController
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
    
    return YES;
}

- (void) testUserNotificationHandler
{
    
    if (@available(iOS 10.0, *)) {
        NSDictionary *payload = @{@"_m":@"NTQxMjoxMTQ6MA", @"_x":@"https://www.google.com"};
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.userInfo = payload;
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"NDY5NjoxMTQ6MA"
                                                                              content:content
                                                                              trigger:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SFMCFoundationUNNotificationReceivedNotification
                                                            object:self
                                                          userInfo:@{@"SFMCFoundationUNNotificationReceivedNotificationKeyUNNotificationRequest": request}];
    }
    else {
        NSDictionary *userInfo = @{@"_m":@"NTQxMjoxMTQ6MA", @"_x":@"https://www.google.com"};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SFMCFoundationUNNotificationReceivedNotification
                                                            object:self
                                                          userInfo:@{@"SFMCFoundationNotificationReceivedNotificationKeyUserInfo": userInfo}];
    }
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


- (UIViewController*) topMostController {
    UITabBarController *topController = (UITabBarController *)self.window.rootViewController;
    UIViewController *topViewController = [topController viewControllers].firstObject;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    
    return topViewController;
}

// Implement the protocol method and use SFSafariViewController to present the URL within your application
- (void) sfmc_handleURL:(NSURL *) url type:(NSString *) type
{
    UIViewController *topViewController = [self topMostController];
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:url];
    if (safariViewController != nil) {
        [topViewController presentViewController:safariViewController animated:YES completion:^{
        }];
    }
}
@end
