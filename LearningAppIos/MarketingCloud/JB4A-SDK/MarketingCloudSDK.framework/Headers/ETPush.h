//
//  ETPush.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ETLocationManager.h"
#import "PushConstants.h"
#import <Availability.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Constants
static NSString * const SDKName DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__")= @"JB4ASDK";


#pragma mark - Protocol

/**
 Supporting protocol for OpenDirect, part of the Salesforce 2013-02 release.
 
 Implementation of this delegate is not required for OpenDirect to function, but it is provided as a convenience to developers who do not with to parse the push payload on their own.
 
 All OpenDirect data is passed down as a JSON String, so you get it as an NSString. Please remember to parse it appropriately from there. Also, please remember to fail gracefully if you can't take action on the message.
 
 Also, please note that setting an OpenDirect Delegate will negate the automatic webpage loading feature added to MobilePush recently. This is deliberately to not stomp on your URLs and deep links.
 */
@protocol ExactTargetOpenDirectDelegate <NSObject>

/**
 Method called when an OpenDirect payload is received from MobilePush.
 
 @param payload value NSString. The contents of the payload as received from MobilePush.
 @deprecated in __DOC_REPLACEME__
 */
-(void)didReceiveOpenDirectMessageWithContents:(NSString *)payload DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

#pragma mark - Optional

@optional

/**
 Allows you to define the behavior of OpenDirect based on application state.
 
 If set to YES, the OpenDirect delegate will be called if a push with an OpenDirect payload is received and the application state is running. This is counter to normal push behavior, so the default is NO.
 
 Consider that if you set this to YES, and the user is running the app when a push comes in, the app will start doing things that they didn't prompt it to do. This is bad user experience since it's confusing to the user. Along these lines, iOS won't present a notification if one is received while the app is running.
 
 @return BOOL representing whether or not you want action to be taken.
 @deprecated in __DOC_REPLACEME__
 */
-(BOOL)shouldDeliverOpenDirectMessageIfAppIsRunning DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

@end

/**
 Supporting protocol for Cloud Pages with Alert, part of the Salesforce 2016-04 release.
 
 Implementation of this delegate is not required for CloudPage with Alert to function, but it is provided as a convenience to developers who do not wish to parse the push payload on their own.
 
 All CloudPage data is passed down as a JSON String, so you get it as an NSString. Please remember to parse it appropriately from there. Also, please remember to fail gracefully if you can't take action on the message.
 
 Also, please note that setting a CloudPage with Alert Delegate will negate the automatic webpage load to inbox feature added to MobilePush.
 */
@protocol ExactTargetCloudPageWithAlertDelegate <NSObject>

/**
 Method called when an Cloud Page with Alert payload is received from MobilePush.
 
 @param payload value NSString. The contents of the payload as received from MobilePush.
 @deprecated in __DOC_REPLACEME__
 */
-(void)didReceiveCloudPageWithAlertMessageWithContents:(NSString *)payload DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

#pragma mark - Optional

@optional

/**
 Allows you to define the behavior of Cloud Page with Alert based on application state.
 
 If set to YES, the Cloud Page with Alert delegate will be called if a push with an Cloud Page with Alert payload is received and the application state is running. This is counter to normal push behavior, so the default is NO.
 
 Consider that if you set this to YES, and the user is running the app when a push comes in, the app will start doing things that they didn't prompt it to do. This is bad user experience since it's confusing to the user. Along these lines, iOS won't present a notification if one is received while the app is running.
 
 @return BOOL representing whether or not you want action to be taken.
 @deprecated in __DOC_REPLACEME__
 */
-(BOOL)shouldDeliverCloudPageWithAlertMessageIfAppIsRunning DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

@end

#pragma mark - Interface

/**
 This is the main interface to the Salesforce MobilePush SDK. It is meant to handle a lot of the heavy lifting with regards to sending data back to Salesforce.
 
 Please note that this is a singleton object, and you should reference it as [ETPush pushManager].
 */
@interface ETPush : NSObject
{
    NSDate *_sessionStart;
    NSString *_messageID;
    
    BOOL _showLocalAlert;
    
    // OpenDirect Delegate stuff
    id<ExactTargetOpenDirectDelegate> _openDirectDelegate;
    
    // CloudPageWithAlert Delegate stuff
    id<ExactTargetCloudPageWithAlertDelegate> _cloudPageWithAlertDelegate;
    
}

#pragma mark - Configure the App for ETPush
/**---------------------------------------------------------------------------------------
 * @name Configuring the app for ETPush
 *  ---------------------------------------------------------------------------------------
 */

/**
 Returns (or initializes) the shared pushManager instance.
 
 @return The singleton instance of an ETPush pushManager.
 @deprecated in __DOC_REPLACEME__
 */
+(nullable instancetype)pushManager DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");
-(nullable instancetype)init DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 This is the main configuration method, responsible for setting credentials needed to communicate with Salesforce. If you are unsure of your accessToken or environment, please visit Code@ExactTarget
 
 Each of the flags in the method are used to control various aspects of the MobilePush SDK. The act as global on/off switches, meaning that if you disable one here, it is off eveywhere.
 
 @param etAppID The App ID generated by Code@ExactTarget to identify the consumer app
 @param accessToken The designed token given to you by Code@ExactTarget that allows you access to the API
 @param analyticsState Whether or not to send analytic data back to Salesforce
 @param locState Whether or not to use Location Services
 @param proximityState Whether or not to use Proximity Services. Using proximity services requires setting locState to YES
 @param cpState Whether or not to use Cloud Pages
 @param pIAnalyticsState Whether or not to send Web and Mobile analytic data back to Salesforce
 @param configureError NSError object describing the error
 @return Returns YES if successful or NO if failed. Do not proceed if NO is returned
 @deprecated in __DOC_REPLACEME__
 */
- (BOOL)configureSDKWithAppID:(NSString *)etAppID
               andAccessToken:(NSString *)accessToken
                withAnalytics:(BOOL)analyticsState
          andLocationServices:(BOOL)locState
         andProximityServices:(BOOL)proximityState
                andCloudPages:(BOOL)cpState
              withPIAnalytics:(BOOL)pIAnalyticsState
                        error:(NSError **)configureError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns state of _showLocalAlert flag
 
 @return BOOL
 @deprecated in __DOC_REPLACEME__
 */
- (BOOL)shouldShowLocalAlert DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Sets the OpenDirect delegate.
 
 @param delegate The object you wish to be called when an OpenDirect message is delivered.
 @deprecated in __DOC_REPLACEME__
 */
-(void)setOpenDirectDelegate:(nullable id<ExactTargetOpenDirectDelegate>)delegate DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns the OpenDirect delegate.
 
 @return delegate The named OpenDirect delegate, or nil if there isn't one.
 @deprecated in __DOC_REPLACEME__
 */
-(nullable id<ExactTargetOpenDirectDelegate>)openDirectDelegate DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Sets the cloudPageWithAlert delegate.
 
 @param delegate The object you wish to be called when an OpenDirect message is delivered.
 @deprecated in __DOC_REPLACEME__
 */
-(void)setCloudPageWithAlertDelegate:(nullable id<ExactTargetCloudPageWithAlertDelegate>)delegate DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns the cloudPageWithAlert delegate.
 
 @return delegate The named cloudPageWithAlert delegate, or nil if there isn't one.
 @deprecated in __DOC_REPLACEME__
 */
-(nullable id<ExactTargetCloudPageWithAlertDelegate>)cloudPageWithAlertDelegate DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Triggers an immediate send of Registration data to Salesforce Marketing Cloud and will wait 60 seconds to send 
 for all calls made after the first call was made while the app is in foreground.
 
 This is not normally needed as each method (setTag(), setSubscriberKey(), addAttribute() etc) will trigger
 a send to the SFMC 60 seconds after the first request to change any Registration data.
 @deprecated in __DOC_REPLACEME__
 */
-(void)updateET DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

#pragma mark - Push Lifecycle
/**---------------------------------------------------------------------------------------
 * @name Push Lifecycle
 *
 * These methods are required to make push function on iOS, and to enable the ET SDK to utilize it. All of these methods are required.
 *  ---------------------------------------------------------------------------------------
 */

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

/**
 
 A one-shot method to get notification up and running in your app.
 
 @param delegate From Apple: "To guarantee that your app is able to respond to actionable notifications, you must set the delegate before your app finishes launching. For example, this means setting the delegate before an iOS app’s applicationDidFinishLaunching: method returns." If desired, -setUserNotificationCenterDelegate may be called early in the app lifecycle, and registration later.
 @param options UNAuthorizationOptions must be passed for registration.
 @param categories A set of UNNotificationCategory objects for push notifications. These may be modified after registration via setUserNotificationCenterCategories.
 @param completionHandler Returns isGranted and error values to convey the results of registration.
 
*/
-(void)registerForRemoteNotificationsWithDelegate:(_Nullable id<UNUserNotificationCenterDelegate>) delegate options:(UNAuthorizationOptions)options categories:(NSSet<UNNotificationCategory *> *_Nullable) categories completionHandler:(void (^)(BOOL granted, NSError *_Nullable error))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method around UNNotificationSettings's authorizationStatus to return registration status as well as the set of options.
 @param completionHandler A handler returning the following: (registered A BOOL value reflecting the authorizationStatus is UNAuthorizationStatusAuthorized or not) (options UNAuthorizationOptions for current registration)
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)registeredForRemoteNotificationsWithCompletionHandler:(void (^)(BOOL registered, UNAuthorizationOptions options))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to return UNNotificationSettings.
 @param completionHandler A handler returning the following: (settings UNNotificationSettings)
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)currentUserNotificationSettingsWithCompletionHandler:(void(^)(UNNotificationSettings *settings))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to set UNUserNotificationCenter's delegate.
 @param delegate A pointer to a class (typically, self) adhering to the UNUserNotificationCenterDelegate protocol
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)setUserNotificationCenterDelegate:(_Nullable id<UNUserNotificationCenterDelegate>) delegate DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to set UNUserNotificationCenter's categories.
 @param categories A set of UNNotificationCategory objects
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)setUserNotificationCenterCategories:(NSSet<UNNotificationCategory *> *_Nullable)categories DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to return get UNUserNotificationCenter categories.
 @param completionHandler A handler returning the following: (categories A set of UNNotificationCategory objects)
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)getUserNotificationCenterCategoriesWithCompletionHandler:(void(^)(NSSet<UNNotificationCategory *> *categories))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to add a notification for delivery.
 @param request A deliverable notification request
 @param completionHandler A handler returning the following: (error An error signifying success or failure)
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)addNotificationRequest:(UNNotificationRequest *)request withCompletionHandler:(nullable void(^)(NSError *__nullable error))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to get notifications pending delivery.
 @param completionHandler A handler returning the following: (requests An array of notification requests)
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)getPendingNotificationRequestsWithCompletionHandler:(void(^)(NSArray<UNNotificationRequest *> *requests))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to remove notifications pending delivery.
 @param identifiers An array of notification identifiers to remove
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)removePendingNotificationRequestsWithIdentifiers:(NSArray<NSString *> *)identifiers DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to remove all notifications pending delivery.
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)removeAllPendingNotificationRequests DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");
/**
 
 A convenience method to get notifications already delivered.
 @param completionHandler A handler returning the following: (notifications An array of delivered notifications)
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)getDeliveredNotificationsWithCompletionHandler:(void(^)(NSArray<UNNotification *> *notifications))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");
/**
 
 A convenience method to remove notifications which have been delivered.
 @param identifiers An array of notification identifiers to remove
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)removeDeliveredNotificationsWithIdentifiers:(NSArray<NSString *> *)identifiers DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 
 A convenience method to remove all notifications which have been delivered.
 
 @deprecated in __DOC_REPLACEME__
 */
- (void)removeAllDeliveredNotifications DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

#endif

// IPHONEOS_DEPLOYMENT_TARGET >= 8.X
// Supports IOS SDK 8.X (i.e. XCode 6.X and up)
/**
 Wrapper for iOS' application:registerForRemoteNotification; call. It will check that push is allowed, and if so, register with Apple for a token. If push is not enabled, it will notify Salesforce that push is disabled.
 
 @deprecated in __DOC_REPLACEME__
 */
-(void)registerForRemoteNotifications DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Wrapper for iOS' isRegisteredForRemoteNotifications; call.
 
 @return BOOL
 @deprecated in __DOC_REPLACEME__
 */
- (BOOL)isRegisteredForRemoteNotifications DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Wrapper for iOS' application:registerUserNotificationSettings; call.
 
 @param notificationSettings The UIUserNotificationSettings object that the application would like to use for push. These are pipe-delimited, and use Apple's native values
 @deprecated in __DOC_REPLACEME__
 */
- (void)registerUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Wrapper for iOS' currentUserNotificationSettings; call.
 
 @return Returns the current UIUserNotificationSettings object
 @deprecated in __DOC_REPLACEME__
 */
- (UIUserNotificationSettings *)currentUserNotificationSettings DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Wrapper for iOS' didRegisterUserNotificationSettings; callback.
 
 @param notificationSettings A UIUserNotificationSettings object
 @deprecated in __DOC_REPLACEME__
 */
- (void)didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");


/**
 Responsible for sending a received token back to Salesforce. It marks the end of the token registration flow. If it is unable to reach ET server, it will save the token and try again later.
 
 This method is necessary to implementation of ET Push.
 
 @param deviceToken Token as received from Apple, still an NSData object
 @deprecated in __DOC_REPLACEME__
 */
-(void)registerDeviceToken:(NSData *)deviceToken DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns the device token as a NSString. As requested via GitHub (Issue #3).
 
 @return A stringified version of the Device Token
 @deprecated in __DOC_REPLACEME__
 */
-(nullable NSString *)deviceToken DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Handles a registration failure.
 
 @param error The error returned to the application on a registration failure
  @deprecated in __DOC_REPLACEME__
 */
-(void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
Reset the application's badge number to zero (aka, remove it). Call updateET to refresh the server with the current badge number. Note: updateET may not be fully processed by the server for a number of minutes; the server's badge value may be out of sync with the app for a short amount of time.
 
*/
-(void)resetBadgeCount DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Tell the SDK to display a UIAlertView if a push is received while the app is already running. Default behavior is set to NO.
 
 Please note that all push notifications received by the application will be processed, but iOS will *not* present an alert to the user if the app is running when the alert is received. If you set this value to true (YES), then the SDK will generate and present the alert for you. It will not play a sound, though.
 
 @param desiredState YES/NO if you want to display an alert view while the app is running.
 @deprecated in __DOC_REPLACEME__
 */
-(void)shouldDisplayAlertViewIfPushReceived:(BOOL)desiredState DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");


#pragma mark - Application Lifecycle
/**---------------------------------------------------------------------------------------
 * @name Application Lifecycle
 *
 * These methods are not necessary for the Push lifecycle, but are required to make the ET Push SDK perform as expected
 *  ---------------------------------------------------------------------------------------
 */

/**
 Notifies the ET SDK of an app launch, including the dictionary sent to the app by iOS. The launchOptions dictionary is necessary because it will include the APNS dictionary, necessary for processing opens and other analytic information.
 
 @param launchOptions The dictionary passed to the application by iOS on launch.
 @deprecated in __DOC_REPLACEME__
 */
-(void)applicationLaunchedWithOptions:(nullable NSDictionary *)launchOptions DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Notifies the ET SDK of an app termination. Internally, this method does a lot of cleanup.
 
 @deprecated in __DOC_REPLACEME__
 */
-(void)applicationTerminated DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");


/** Handles a notification received by the app
 
 @param userInfo The dictionary containing the push notification payload
 @param applicationState UIApplicationState value used as a hint to the SDK to describe if the app was in the foreground or background when the notification payload is received by the application delegate, thereby facilitating propery SDK behavior and logging
 @deprecated in __DOC_REPLACEME__
 */
- (void) handleNotification:(NSDictionary *)userInfo forApplicationState:(UIApplicationState)applicationState DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/** Handles a notification received by the app (typically, in response to -application:didReceiveRemoteNotification:fetchCompletionHandler:)
 
 @param userInfo The dictionary containing the push notification payload
 @deprecated in __DOC_REPLACEME__
 */
- (void) handleRemoteNotification:( NSDictionary * _Nullable ) userInfo DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/** Handles a notification received by the app (in response to -application:didReceiveLocalNotification:)
 
 @param localNotification The localNotification received by the application
 @deprecated in __DOC_REPLACEME__
 */
- (void) handleLocalNotification:( UILocalNotification * _Nullable ) localNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
/** Handles an iOS 10 notification received by the app (in response to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)
 
 @param notificationResponse The UNNotificationResponse received by the application
 @deprecated in __DOC_REPLACEME__
 */
- (void) handleUserNotificationResponse:(UNNotificationResponse * _Nullable ) notificationResponse DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");
#endif


#pragma mark - Data Interaction
/**---------------------------------------------------------------------------------------
 * @name Data Interaction
 *  ---------------------------------------------------------------------------------------
 */

/**
 Accepts and sets the Subscriber Key for the device's user.
 
 Cannot be nil or blank.
 
 Will trim leading and trailing whitespace.
 
 @param subscriberKey The subscriber key to attribute to the user.
 @return YES if set successfully
 @deprecated in __DOC_REPLACEME__
 */
-(BOOL)setSubscriberKey:(NSString *)subscriberKey DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns the subscriber key for the active user, in case you need it.
 
 @return subscriberKey The code-set subscriber key.
 @deprecated in __DOC_REPLACEME__
 */
-(nullable NSString *)getSubscriberKey DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Adds the provided Tag (NSString) to the set of unique tags.
 
 Will trim leading and trailing whitespace.
 
 Cannot be nil or blank.
 
 @param  tag A string to add to the list of tags
 @return YES if added successfully.
 @deprecated in __DOC_REPLACEME__
 */
-(BOOL)addTag:(NSString *)tag DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Removes the provided Tag (NSString) from the list of tags.
 
 @param tag A string to remove from the list of tags
 @return tag Echoes the tag back on successful removal, or nil if something failed.
 @deprecated in __DOC_REPLACEME__
 */
-(nullable NSString *)removeTag:(NSString *)tag DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns the list of tags for this device.
 
 @deprecated Feb 29 2016
 @return All tags associated.
 @deprecated in __DOC_REPLACEME__
 */
-(NSSet *)allTags DEPRECATED_MSG_ATTRIBUTE("allTags is deprecated. Please use getTags instead.");

/**
 Returns the list of tags for this device.
 
 @return All tags associated.
 @deprecated in __DOC_REPLACEME__
 */
-(NSSet *)getTags DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Adds an attribute to the data set sent to Salesforce.
 
 The Attribute Name cannot be nil or blank, or one of the reserved words.
 
 Will trim leading and trailing whitespace from the name and value.
 
 The attribute must be defined within the SFMC Contact model prior to adding a value.  If the attribute does not exist within the
 SFMC Contact model, then this attribute will be accepted by the SDK, but will be ignored within the SFMC.
 
 If you previously added a value for the named attribute, then the value will be updated with the new value and sent to the SFMC.
 
 If you send in a blank value, then the value will be sent to the SFMC to remove that value from the Contact record.

 All attribute values set with this method persist through the installation of the app on your customer device.
 
 Note that attribute mapping is case sensitive, and spaces should be avoided when setting up new attributes in the SFMC Contact model.
 
 @param name The name of the attribute you wish to send. This will be the key of the pair.
 @param value The value to set for the data pair.
 @return YES if added successfully
 @deprecated in __DOC_REPLACEME__
 */
- (BOOL)addAttributeNamed:(NSString*)name value:(NSString*)value DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Removes the provided attribute from the data set to send to Salesforce.  The value is not changed on the SFMC.
 
 @param name The name of the attribute you wish to remove.
 @return Returns the value that was set. It will no longer be sent back to Salesforce.
 @deprecated in __DOC_REPLACEME__
 */
- (nullable NSString*)removeAttributeNamed:(NSString*)name DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns a read-only copy of the Attributes dictionary as it is right now.
 
 @deprecated Feb 29 2016
 @return All attributes currently set
 @deprecated in __DOC_REPLACEME__
 */
-(NSDictionary *)allAttributes DEPRECATED_MSG_ATTRIBUTE("allAttributes has been deprecated. Please use getAttributes instead");

/**
 Returns a read-only copy of the Attributes dictionary as it is right now.
 
 @return All attributes currently set
 @deprecated in __DOC_REPLACEME__
 */
-(NSDictionary *)getAttributes DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 @name Listeners for UIApplication events
 @deprecated in __DOC_REPLACEME__
 */

/**
 Sets up the listeners.
 @deprecated in __DOC_REPLACEME__
 */
-(void)startListeningForApplicationNotifications DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Drops the listeners.
 @deprecated in __DOC_REPLACEME__
 */
-(void)stopListeningForApplicationNotifications DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Responds to the UIApplicationDidBecomeActiveNotification notification
 @deprecated in __DOC_REPLACEME__
 */
-(void)applicationDidBecomeActiveNotificationReceived DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__"); // UIApplicationDidBecomeActiveNotification

/**
 Responds to the UIApplicationDidEnterBackgroundNotification notification
 @deprecated in __DOC_REPLACEME__
 */
-(void)applicationDidEnterBackgroundNotificationReceived DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__"); // UIApplicationDidEnterBackgroundNotification

#pragma mark - ETPush Convenience Methods
/**
 @name ETPush Convenience Methods
 */

/**
 Gets the Apple-safe, unique Device Identifier that ET will later use to identify the device.
 
 Note that this method is compliant with Apple's compliance rules, but may not be permanent.
 @deprecated in __DOC_REPLACEME__
 */
+(NSString *)safeDeviceIdentifier DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns the hardware identification string, like "iPhone1,1". Salesforce uses this data for segmentation.
 
 @return A string of the hardware identification.
 @deprecated in __DOC_REPLACEME__
 */
+(NSString *)hardwareIdentifier DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Returns whether this device can receive Push Notifications.
 
 Push is considered enabled if the application is able to present an alert (banner, alert, sound) to the user.  If UIUserNotificationTypeNone (ios8+) or
 UIRemoteNotificationTypeNone (iOS7) is true, then Push is disabled and this method returns false.  For iOS8+, isRegisteredForRemoteNotifications
 must also return true.
 @deprecated in __DOC_REPLACEME__
 */
+(BOOL)isPushEnabled DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Get SDK Version Name
 @deprecated in __DOC_REPLACEME__
 */
+(NSString *)getSDKVersionName DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Get SDK Version Code
 
 @return NSString value.
 @deprecated in __DOC_REPLACEME__
 */
+(NSString *)getSDKVersionCode DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Set the Log Level
 
 @param state type BOOL value.
 @deprecated in __DOC_REPLACEME__
 */
+(void)setETLoggerToRequiredState:(BOOL)state DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 To override the logging that the SDK does with your own logging code.  Adding this logging handler will
 replace the logs that the SDK prints to the console.
 
 Typical uses would be to save the logs in your own logging datastore instead of printing to the console.
 
 NOTE: Do not base any program logic on the contents of the String received as a parameter as we do not guarantee
 the contents of a log string will remain the same from one release to another.
 
 @param customLogger - A completion handler that will be called each time the SDK logs to the console.  Instead of
                       calling NSLog to log to the console, the SDK will call this customLogger and provide the String
                       that was going to be logged.
 @deprecated in __DOC_REPLACEME__
 */
+(void) setLoggerWithHandler:( void (^__nullable)(NSString *))customLogger DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Outputs a formatted, easily readable block of text describing the current status of the SDK.
 
 @return JSON string with values of the current state of the SDK
 @deprecated in __DOC_REPLACEME__
 */
+(nullable NSString *)getSDKState DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Ask ETPush to update its data. ETPush will throttle attempts based on the time since the last time this was called.
 
 @param completionHandler The UIBackgroundFetchResult completion handler. This method will be called with UIBackgroundFetchResultNoData if no attempt was made to update data, otherwise it will be called with UIBackgroundFetchResultNewData after the update completes. If nil is passed, then process of the completion handler must be managed by the caller.
 @return True if ETPush did make an attempt at updating data
 @deprecated in __DOC_REPLACEME__
 */
- (BOOL) refreshWithFetchCompletionHandler:(void (^__nullable)(UIBackgroundFetchResult result))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Used to retrieve a JSON formatted string of recommendations from the Predictive Web section of the Marketing Cloud.
 
 @param mid An identifier used to locate the application specific recommendations
 @param page A recommendations page that has been created within the Predictive Web section of the Marketing Cloud
 @param error A pointer to a location to store an NSError object describing any error that occurred while sanity checking the input parameters. Can be nil.
 @param completionHandler A pointer to a user-supplied completion handler block. The completion handler will be called if requestPIRecommendations returns True. The result parameter of the completion handler will contain a JSON formatted string with the recommendations on a successfull call otherwise it will be nil and the error parameter will be filled with an NSError object describing the error.
 @return Returns T/F based on sanity checks of the input parameters. If False is returned the user completion handler will not be called.
 @deprecated in __DOC_REPLACEME__
 */
+(BOOL)requestPIRecommendations:(NSString *)mid page:(NSString *)page error:(NSError **)error completionHandler:(void (^)(NSString *result, NSError *error))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");
/**
 Used to retrieve a JSON formatted string of recommendations from the Predictive Web section of the Marketing Cloud.
 
 @param mid An identifier used to locate the application specific recommendations
 @param page A recommendations page that has been created within the Predictive Web section of the Marketing Cloud
 @param retailer An identifier used to locate the application specific recommendations
 @param error A pointer to a location to store an NSError object describing any error that occurred while sanity checking the input parameters. Can be nil.
 @param completionHandler A pointer to a user-supplied completion handler block. The completion handler will be called if requestPIRecommendations returns True. The result parameter of the completion handler will contain a JSON formatted string with the recommendations on a successfull call otherwise it will be nil and the error parameter will be filled with an NSError object describing the error.
 @return Returns T/F based on sanity checks of the input parameters. If False is returned the user completion handler will not be called.
 @deprecated in __DOC_REPLACEME__
 */
+(BOOL)requestPIRecommendations:(NSString *)mid page:(NSString *)page retailer:(NSString *)retailer error:(NSError **)error completionHandler:(void (^)(NSString *result, NSError *error))completionHandler DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");


+(NSArray *)getCloudPages DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

@end
NS_ASSUME_NONNULL_END

