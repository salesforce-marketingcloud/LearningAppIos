//
//  MarketingCloudSDK.h
//  MarketingCloudSDK
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 MarketingCloudSDK EventBus constants
 */

extern NSString * _Nonnull const kMarketingCloudSDKDidDisplayLocationMessageNotification;
extern NSString * _Nonnull const kMarketingCloudSDKDidReceiveGeofenceResponseNotification;
extern NSString * _Nonnull const kMarketingCloudSDKDidReceiveBeaconResponseNotification;
extern NSString * _Nonnull const kMarketingCloudSDKDidEnterGeofenceNotification;
extern NSString * _Nonnull const kMarketingCloudSDKDidExitGeofenceNotification;
extern NSString * _Nonnull const kMarketingCloudSDKDidRangeBeaconNotification;
extern NSString * _Nonnull const kMarketingCloudSDKDidReceiveRichMessagesNotification;
extern NSString * _Nonnull const kMarketingCloudSDKDidReceiveCloudPagesNotification;
extern NSString * _Nonnull const kMarketingCloudSDKDidReceiveLocationUpdateNotification;

/**
 Enumeration of the type of MarketingCloudSDKEventMessageObject this is.
 */
typedef NS_ENUM(NSUInteger, MarketingCloudSDKMobilePushMessageType)
{
    /** Initial enum value  */
    firstMarketingCloudSDKMobilePushMessageTypeIndex = 0,
    /** Unknown */
    MarketingCloudSDKMobilePushMessageTypeUnknown = firstMarketingCloudSDKMobilePushMessageTypeIndex,
    /** Basic - A standard push message */
    MarketingCloudSDKMobilePushMessageTypeBasic ,
    /** Geofence Entry */
    MarketingCloudSDKMobilePushMessageTypeFenceEntry = 3,
    /** Geofence Exit */
    MarketingCloudSDKMobilePushMessageTypeFenceExit ,
    /** Proximity */
    MarketingCloudSDKMobilePushMessageTypeProximity ,
    /** lastMobilePushMessageTypeIndex */
    lastMarketingCloudSDKMobilePushMessageTypeIndex = MarketingCloudSDKMobilePushMessageTypeProximity
};

/**
 Bitmask of features that a message has. This is the representation of Push (AlertMessage), Push+Page (AlertMessage + Page), Page Only (Page) in the MobilePush UI.
 */
typedef NS_OPTIONS(NSUInteger, MarketingCloudSDKMobilePushContentType) {
    /** Unknown */
    MarketingCloudSDKMobilePushContentTypeNone = 0,
    /** Push Message */
    MarketingCloudSDKMobilePushContentTypeAlertMessage = 1 << 0,
    /** CloudPage */
    MarketingCloudSDKMobilePushContentTypePage = 1 << 1,
    /** Enhanced Cloud Page – Pushed Cloud Pages */
    MarketingCloudSDKMobilePushContentTypeEcp = 1 << 31
};

/**---------------------------------------------------------------------------------------
 * @name This is the main interface to the MarketingCloudSDK, via the shared instance sfmcSDK.
 *  ---------------------------------------------------------------------------------------
 */

@interface MarketingCloudSDK : NSObject

/**---------------------------------------------------------------------------------------
 * @name Configuring the app for Salesforce Marketing Cloud
 *  ---------------------------------------------------------------------------------------
 */
/**
 Returns (or initializes) the shared sdk instance. This is the default and suggested reference to the SDK.
 
 @return The singleton instance of an MarketingCloudSDK sfmcSDK.
 */
+(instancetype _Nullable)sfmcSDK;

/**
 This is the main configuration method, responsible for setting credentials needed to communicate with Salesforce. If you are unsure of your accessToken or environment, please visit Code@ExactTarget
 
 Each of the flags in the method are used to control various aspects of the MobilePush SDK. The act as global on/off switches, meaning that if you disable one here, it is off eveywhere.
 
 @param appID The App ID generated by Code@ExactTarget to identify the consumer app
 @param accessToken The designed token given to you by Code@ExactTarget that allows you access to the API
 @param analyticsEnabled Whether or not to send analytic data back to Salesforce
 @param locationServicesEnabled Whether or not to use Location Services
 @param proximityServicesEnabled Whether or not to use Proximity Services. Using proximity services requires setting locationServicesEnabled to YES.
 @param cloudPagesEnabled Whether or not to use Cloud Pages
 @param piAnalyticsEnabled Whether or not to send Web and Mobile analytic data back to Salesforce
 @param configurationError NSError object describing the error
 @return Returns YES if successful or NO if failed. Do not proceed if NO is returned
 */
- (BOOL) sfmc_configureSDKWithAppID:(NSString * _Nonnull)appID
                        accessToken:(NSString *_Nonnull)accessToken
                   analyticsEnabled:(BOOL)analyticsEnabled
            locationServicesEnabled:(BOOL)locationServicesEnabled
           proximityServicesEnabled:(BOOL)proximityServicesEnabled
                  cloudPagesEnabled:(BOOL)cloudPagesEnabled
                 piAnalyticsEnabled:(BOOL)piAnalyticsEnabled
                              error:(NSError * _Nullable * _Nullable)configurationError;

/**
 Triggers an immediate send of Registration data to Salesforce Marketing Cloud and will wait 60 seconds to send
 for all calls made after the first call was made while the app is in foreground.
 
 This is not normally needed as each method (sfmc_setTag, sfmc_setContactKey, sfmc_addAttribute etc) will trigger
 a send to Salesforce 60 seconds after the first request to change any Registration data.
 */
-(void) sfmc_updateMarketingCloud;

@end
