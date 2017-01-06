//
//  MarketingCloudSDKEventRegionObject.h
//  JB4A-SDK-iOS
//
//  Copyright © 2016 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketingCloudSDKCartObject.h"

@interface MarketingCloudSDKOrder : NSObject <NSCoding, NSCopying>

/**
 Initialize an Order object for use in analytics.
 
 @param orderNumber The order number of from the e-commerce system (non-nil string)
 @param shipping The shipping amount (USD) of this order (non-nil value; 0 permissable)
 @param discount The discount amount (USD) of this order (non-nil value; 0 permissable)
 @param cart The order's shopping cart object (non-nil object)
 @return instancetype
 */
- (instancetype _Nullable)initWithOrderNumber:(NSString * _Nonnull) orderNumber shipping:(NSNumber * _Nonnull) shipping discount:(NSNumber * _Nonnull) discount cart:(MarketingCloudSDKCart * _Nonnull) cart NS_DESIGNATED_INITIALIZER;

/**
 Convert MarketingCloudSDKOrder to dictionary.
 
 @return NSDictionary
 */
- (NSDictionary * _Nonnull)dictionaryRepresentation;

@end
