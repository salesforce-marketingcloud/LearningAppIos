//
//  MarketingCloudSDK+Analytics.h
//  JB4A-SDK-iOS
//
//  Created by Brian Criscuolo on 12/1/16.
//  Copyright © 2016 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"
#import "MarketingCloudSDKCartObject.h"
#import "MarketingCloudSDKOrderObject.h"

@interface MarketingCloudSDK (Analytics)

- (BOOL) testBaseAnalytics;

/**
 Set Web Analytics Mobile Analytics, Track page views within your application.
 @param url a non-nil NSString to identify the location within your app traversed by your customers.  For example: com.yourpackage.viewcontrollername
 @param title a NSString (nil if n/a) to identify the title of the location within your app traversed by your customers. For example: Screen Name
 @param item a NSString (nil if n/a) to identify an item viewed by your customer.  For example: UPC-1234
 @param search a NSString (nil if n/a) to identify search terms used by your customer.  For example: blue jeans.
 */
+(void)sfmc_trackPageView:(NSString * _Nonnull)url andTitle:(NSString * _Nullable)title andItem:(NSString *_Nullable)item andSearch:(NSString * _Nullable)search;

/**
 Set Web Analytics Mobile Analytics, Track cart contents within your application.
 @param cart a non-nil PICart object containing a cartID and an array of PICartItems
 */
+(void)sfmc_trackCartContents:(MarketingCloudSDKCart * _Nonnull) cart;

/**
 Set Web Analytics Mobile Analytics, Track cart conversion within your application.
 @param order a non-nil PIOrder object representing an order; created from a cart and cart items and "converted" into a sale of some sort
 */
+(void)sfmc_trackCartConversion:(MarketingCloudSDKOrder * _Nonnull) order;

@end
