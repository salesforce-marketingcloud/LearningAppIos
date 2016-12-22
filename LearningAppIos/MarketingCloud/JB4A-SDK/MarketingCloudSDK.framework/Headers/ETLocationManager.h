//
//  ETLocationManager.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PushConstants.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Local definitions of the LocationUpdateAppState enumeration.
 */
typedef NS_ENUM(NSInteger, LocationUpdateAppState)
{
	/** First enum value */
    firstLocationUpdateAppStateIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** LocationUpdateAppStateBackground */
    LocationUpdateAppStateBackground DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = firstLocationUpdateAppStateIndex,
    /** LocationUpdateAppStateForeground */
    LocationUpdateAppStateForeground DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__"),
    /** lastLocationUpdateAppStateIndex */
    lastLocationUpdateAppStateIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = LocationUpdateAppStateForeground
};

/*!
 ETLocationManager is the main interface to Salesforce's Location Services. In the way that ETPush manages the push notification cycle, ETLocationMangaer manages geo services. It will use some of the information from ETPush (namely, App ID and Access Token) to function, but is an independent piece of functionality.
 
  Due to the invasive nature of location services, ETLocationManager defaults to off, and must be explicity turned on by the developer, whether invisibly to the user or not. To begin location services, call [ [ETLocationManager sharedInstance]startWatchingLocation]. Similarly, to stop location services, call [ [ETLocationManager sharedInstance]stopWatchingLocation].
 
 ETLocationManager will always respect the user's wishes (as enforced by iOS), so if the user disables Location Services at the system level through Settings, the SDK will be unable to use any location services, and fence monitoring will not function. You can check for this by querying [ [ETLocationManager sharedInstance] locationEnabled], as it will reconcile app-level permissions as well as the state of you enabling loc services. Internally, this method is used to report back to Salesforce on the state of location services, so it is trustworthy.
 
 Please ensure you are linking against CoreLocation. You will get errors otherwise. 
 
 */
@interface ETLocationManager : NSObject <CLLocationManagerDelegate>
{

}

/**
 Keeps track of if we are currently in the middle of updating Geofences. That should only work one at a time.
 @deprecated in __DOC_REPLACEME__
 */
@property (nonatomic, getter = isUpdatingGeofences) BOOL updatingGeofences __attribute__((deprecated("__REPLACEME__")));

/**
 Returns a reference to the shared loc manager.
 This method is deprecated. Please use sharedInstance instead.
 @deprecated in __DOC_REPLACEME__
 */
+(ETLocationManager *)locationManager DEPRECATED_MSG_ATTRIBUTE("The locationManager method is deprecated. Please use sharedInstance instead.");

/**
  + Returns a reference to the shared ETLocationManager
  @deprecated in __DOC_REPLACEME__
 */

+(instancetype)sharedInstance DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

-(instancetype)init DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");
   
/**
 Determines the state of Location Services based on developer setting and OS-level permission. This is the preferred method for checking for location state.
 @deprecated in __DOC_REPLACEME__
 */
-(BOOL)locationEnabled DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Use this method to initiate Location Services through the MobilePush SDK. 
 @deprecated in __DOC_REPLACEME__
 */
-(void)startWatchingLocation DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");
    
/** 
 Use this method to disable Location Services through the MobilePush SDK.
 @deprecated in __DOC_REPLACEME__
 */
-(void)stopWatchingLocation DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Calls various handlers that should fire when the app enters the foreground. 
 @deprecated in __DOC_REPLACEME__
 */
-(void)appInForeground DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/** Calls various handlers that should fire when the app enters the background.
 @deprecated in __DOC_REPLACEME__
 */
-(void)appInBackground DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Updates the current location and retrieves geo-fence messages.
 
 @param loc a CLLocation value.
 @param state a LocationUpdateAppState value.
 @deprecated in __DOC_REPLACEME__
 */
-(void)updateLocationAndRetrieveMessages:(CLLocation *)loc forAppState:(LocationUpdateAppState)state DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");


/* Location */
/**
 Takes in an NSSet of fences that should be monitored.
 @param fences The set to monitor. 
 @param requestType ETRegionRequestType NS_ENUM value
 
 @deprecated in __DOC_REPLACEME__
 */
-(void)monitorRegions:(NSSet<__kindof CLRegion *> *)fences ofRequestType:(ETRegionRequestType)requestType DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Instructs the CLLocationManager to stop monitoring all regions. 
 @deprecated in __DOC_REPLACEME__
 */
-(void)stopMonitoringRegions DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");


/**
 Returns the currently monitored regions. 
 @return An NSSet of monitored regions.
 @deprecated in __DOC_REPLACEME__
 */
-(NSSet<__kindof CLRegion *> *)monitoredRegions DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 A dictionary version of the Last Known Location. The dictionary will contain two keys, latitude and longitude, which are NSNumber wrappers around doubles. Use doubleValue to retrieve.
 @deprecated in __DOC_REPLACEME__
 */
-(NSDictionary<NSString *, NSString *> *)lastKnownLocation DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/* For Tests */
/**
 Returns if we are currently watching location. 
 @return T/F if locations are being watched.
 @deprecated in __DOC_REPLACEME__
 */
- (BOOL) getWatchingLocation DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");; 

@end
NS_ASSUME_NONNULL_END
