//
//  MarketingCloudSDKEventRegionObject.h
//  JB4A-SDK-iOS
//
//  Copyright © 2016 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MarketingCloudSDKCart : NSObject <NSCoding, NSCopying>

/**
 Initialize a Cart object for use in analytics.
 
 @param cartItems An array of MarketingCloudSDKCartItem objects (non-nil array). An empty array indicates an empty cart, and will be used to indicate a cleared cart to the analytics system.
 @return instancetype
 */
- (instancetype _Nullable)initWithCartItems:(NSArray * _Nonnull) cartItems NS_DESIGNATED_INITIALIZER;

/**
 Convert MarketingCloudSDKCart to dictionary.
 
 @return NSDictionary
 */
- (NSDictionary * _Nonnull)dictionaryRepresentation;

@end
