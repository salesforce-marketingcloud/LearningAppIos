//
//  MarketingCloudSDK+Helpers.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"

@interface MarketingCloudSDK (Location)

/**
 Determines the state of Location Services based on developer setting and OS-level permission. This is the preferred method for checking for location state.
 
 @return A boolean value reflecting if location services are enabled (i.e. authorized) or not.
 */
-(BOOL)sfmc_locationEnabled;

/**
 Use this method to initiate Location Services through the MobilePush SDK.
 */
-(void)sfmc_startWatchingLocation;

/**
 Use this method to disable Location Services through the MobilePush SDK.
 */
-(void)sfmc_stopWatchingLocation;

/**
 Returns the currently monitored regions.
 @return An NSSet of monitored CLRegion regions.
 */
- (NSSet * _Nonnull)sfmc_monitoredRegions;

@end
