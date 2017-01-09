//
//  MarketingCloudSDK+Helpers.h
//  JB4A-SDK-iOS
//
//  Created by Brian Criscuolo on 12/1/16.
//  Copyright © 2016 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"

@interface MarketingCloudSDK (Location)

- (BOOL) testBaseLocation;

/**
 Determines the state of Location Services based on developer setting and OS-level permission. This is the preferred method for checking for location state.
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
