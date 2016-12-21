//
//  ETAnalytics.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce. All rights reserved.
//

/*!
 @class ETAnalytics
 
 Wrapper class for sending WAMA PI Analytic values using a public interface.
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PIOrder;
@class PICart;

@interface ETAnalytics : NSObject

/**
 Set Web Analytics Mobile Analytics, Track page views within your application.
 @param url a non-nil NSString to identify the location within your app traversed by your customers.  For example: com.yourpackage.viewcontrollername
 @param title a NSString (nil if n/a) to identify the title of the location within your app traversed by your customers. For example: Screen Name
 @param item a NSString (nil if n/a) to identify an item viewed by your customer.  For example: UPC-1234
 @param search a NSString (nil if n/a) to identify search terms used by your customer.  For example: blue jeans.
 
 @deprecated in __DOC_REPLACEME__
 */
+(void)trackPageView:(NSString*)url andTitle:(nullable NSString*)title andItem:(nullable NSString *)item andSearch:(nullable NSString*)search DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Set Web Analytics Mobile Analytics, Track cart contents within your application.
 @param cart a non-nil PICart object containing a cartID and an array of PICartItems
 @deprecated in __DOC_REPLACEME__
 */
+(void)trackCartContents:(PICart * _Nonnull) cart DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Set Web Analytics Mobile Analytics, Track cart conversion within your application.
 @param order a non-nil PIOrder object representing an order; created from a cart and cart items and "converted" into a sale of some sort
 @deprecated in __DOC_REPLACEME__
 */
+(void)trackCartConversion:(PIOrder * _Nonnull) order DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

@end
NS_ASSUME_NONNULL_END
