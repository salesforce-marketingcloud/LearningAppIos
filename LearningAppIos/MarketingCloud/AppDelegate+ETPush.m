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

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_3
#import <UserNotifications/UserNotifications.h>
#endif

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

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_3

        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_9_x_Max) {
            [[ETPush pushManager] registerForRemoteNotificationsWithDelegate:nil options:(UNAuthorizationOptionAlert + UNAuthorizationOptionBadge + UNAuthorizationOptionSound) categories:nil completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
                NSLog(@"Registered for remote notifications: %d", granted);
                
            }];
        }
        else {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound |
                                                    UIUserNotificationTypeAlert
                                                                                     categories:nil];
            // Notify the SDK what user notification settings have been selected
            [[ETPush pushManager] registerUserNotificationSettings:settings];
            [[ETPush pushManager] registerForRemoteNotifications];
        }
#else
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound |
                                                UIUserNotificationTypeAlert
                                                                                 categories:nil];
        // Notify the SDK what user notification settings have been selected
        [[ETPush pushManager] registerUserNotificationSettings:settings];
        [[ETPush pushManager] registerForRemoteNotifications];
#endif
        
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
    
    [self performSelector:@selector(testNotificationStuff) withObject:nil afterDelay:5.0];
    
    return YES;
}

- (void) testNotificationStuff {

    [[ETPush pushManager] registeredForRemoteNotificationsWithCompletionHandler:^(BOOL registered, UNAuthorizationOptions options) {
        NSLog(@"registered: %ld, %ld", (long) registered, (unsigned long)options);
    }];
    
    [[ETPush pushManager] currentUserNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings) {
        NSLog(@"settings: %@", settings);
    }];
    
    [[ETPush pushManager] setUserNotificationCenterDelegate:nil];
    
    UNNotificationAction *action = [UNNotificationAction actionWithIdentifier:@"1234567890" title:@"actionTitle" options:UNNotificationActionOptionForeground];
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"1234567890" actions:@[action] intentIdentifiers:@[@"867-5309"] options:UNNotificationCategoryOptionNone];
    NSSet<UNNotificationCategory *> *categories = [NSSet setWithObject:category];
    
    [[ETPush pushManager] setUserNotificationCenterCategories:categories];
    
    [[ETPush pushManager] getUserNotificationCenterCategoriesWithCompletionHandler:^(NSSet *categories) {
        NSLog(@"categories: %@", categories);
    }];


    NSString *identifier = [[NSUUID UUID] UUIDString];
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"Hello_message_body"
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    
    // Deliver the notification in ten seconds.
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:10 repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:trigger];
    
    [[ETPush pushManager] addNotificationRequest:request withCompletionHandler:^(NSError * error) {
        NSLog(@"addNotificationError: %@", error);

        [[ETPush pushManager] getPendingNotificationRequestsWithCompletionHandler:^(NSArray *requests) {
            // Count of pending requests should be 1
            NSLog(@"pendingRequests: %@", requests);

            // Remove our request
            [[ETPush pushManager] removePendingNotificationRequestsWithIdentifiers:@[identifier]];
            
            // Check the count
            [[ETPush pushManager] getPendingNotificationRequestsWithCompletionHandler:^(NSArray *requests) {
                // Count of pending requests should now be 0
                NSLog(@"pendingRequests: %@", requests);
                
                // Lets do it again, with that same request
                [[ETPush pushManager] addNotificationRequest:request withCompletionHandler:^(NSError * error) {
                    NSLog(@"addNotificationError: %@", error);
                    
                    [[ETPush pushManager] getPendingNotificationRequestsWithCompletionHandler:^(NSArray *requests) {
                        // Count of pending requests should be 1
                        NSLog(@"pendingRequests: %@", requests);
                        
                        // Remove all requests
                        [[ETPush pushManager] removeAllPendingNotificationRequests];
                        
                        // Check the count
                        [[ETPush pushManager] getPendingNotificationRequestsWithCompletionHandler:^(NSArray *requests) {
                            // Count of pending requests should now be 0
                            NSLog(@"pendingRequests: %@", requests);
                            
                            // Last time around, with delivery!
                            [[ETPush pushManager] addNotificationRequest:request withCompletionHandler:^(NSError * error) {
                                NSLog(@"addNotificationError: %@", error);
                                
                                sleep(10);
                                
                                [[ETPush pushManager] getDeliveredNotificationsWithCompletionHandler:^(NSArray *notifications) {
                                    // Count should be 1
                                    NSLog(@"deliveredNotifications: %@", notifications);
                                    
                                    [[ETPush pushManager] removeDeliveredNotificationsWithIdentifiers:@[identifier]];
                                    
                                    // or...
                                    [[ETPush pushManager] removeAllDeliveredNotifications];
                                    
                                    // Check the count
                                    [[ETPush pushManager] getDeliveredNotificationsWithCompletionHandler:^(NSArray *requests) {
                                        // Count of pending requests should now be 0
                                        NSLog(@"deliveredRequests: %@", requests);
                                    }];
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_3

#pragma mark - Lifecycle Callbacks

// The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    if (completionHandler != nil) {
        completionHandler(UNNotificationPresentationOptionAlert);
    }
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    
    /**
     Inform the JB4ASDK that the device received a remote notification
     */
    [[ETPush pushManager] handleUserNotificationResponse:response];
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
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

    if (completionHandler != nil) {
        completionHandler();
    }
}

#endif


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

#pragma mark Cloud Page delegates
- (void)didReceiveCloudPageWithAlertMessageWithContents:(NSString *)payload {
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[ETWKLandingPagePresenter alloc] initForLandingPageAt:payload]
                                                                                 animated:YES
                                                                               completion:nil];
}

-(BOOL)shouldDeliverCloudPageWithAlertMessageIfAppIsRunning {
    return YES;
}


@end
