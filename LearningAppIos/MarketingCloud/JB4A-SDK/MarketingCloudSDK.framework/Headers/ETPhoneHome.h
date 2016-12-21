//
//  ETPhoneHome.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce Marketing Cloud. All rights reserved.
//
//  This object themed intentionally. 

#import <UIKit/UIKit.h>
#import "ETGenericUpdate.h"
#import "PIEvent.h"
#import "ETInternalConstants.h"

NS_ASSUME_NONNULL_BEGIN

#define BaseRequestURL @"https://consumer.exacttargetapis.com"

/**
 The key that is used to store the access token inside ETGeneralSettings
 */
static NSString * const PIANALYTICS_SESSIONID = @"PIAnalytics_SessionID";
static NSString * const PIANALYTICS_USERID = @"PIAnalytics_UserID";
static NSString * const PIANALYTICS_DATE = @"PIAnalytics_Date";
static NSTimeInterval PIANALYTICS_TIMEOUT = 1800; //30 minutes

/**
 ETPhoneHome is like a highway management system, governing the sending of data to and from Salesforce, and caching that which can't get sent home. It works by marshalling around GenericUpdate object subclasses, which themselves create a common pattern for handling business.
 
 Data should be sent back using phoneHome:, which will start the process of sending data to ET, and failing that, save it to the database. The behavior is all controlled by methods on the GenericUpdate object.
 
 */
@interface ETPhoneHome : NSObject

@property (atomic, strong, nullable) NSURLSession *session;

/**
  Singleton accessor. This isn't to be publicly used, so we can have a sense of humor about it. 
 */
+(nullable instancetype)magicBicycle;

/**
 Begins the process of sending data back to Salesforce.
 
 @param updateObject A subclass of GenericUpdate that wants to be send to ET.
 
 @return bool Whether or not it was able to send to ET. 
 */
-(BOOL)phoneHome:(ETGenericUpdate *)updateObject;

/**
 Cancels active network session tasks.
 */
- (void) cancelSession;

/**
 This is a clone of phoneHomeInBulkForGenericUpdateType and uses the same core functionality of it, however differs in the fact that we are passing in the PIEvent as an updateObject. This means we conditionally set the PIEvent table's claimed field based upon whether the passed in piEvent object's analyticType is a TrackView or TrackEvent to be deleted upon successful send. One additional important difference is that we are setting up the bulk as an array of dictionarys to be sent out as the phoneHomeInBulkForGenericUpdateType method does, but we will alyways send out only one element in the array. The reason for this is because we want to reuse the same inherited ETBulkUpdateShim block as a callback when we receive a successful server response without having to recreate all of this functionality.
 
 @param analyticType a PIEventStatisticType value. UpdateObject A subclass of GenericUpdate that wants to be send to ET. In our case will always be used for PIEvent.
 @return BOOL Whether or not it was able to send to ET.
 */
-(BOOL)phoneHomeForPIEventType:(PIEventStatisticType)analyticType;

/**
 Begins the process of sending data back to Salesforce, but does so for bulk data. This is different than phoneHome: because it will send an array of things, and not just one object.
 
 @param updateClass a Class value
 @return BOOL value
 */
-(BOOL)phoneHomeInBulkForGenericUpdateType:(Class)updateClass;

/**
 Saves the udpate object to the database in the event of a send failure. It is exposed in the header because some objects just need to be saved instead of sent. This method should not be used publicly. 
 
 @param updateObject a ETGenericUpdate value. The subclass of GenericUpdate to save to the database.
 @return bool Whether or not the save succeeded. Sometimes they don't. 
 */
-(BOOL)saveToDatabaseInstead:(ETGenericUpdate *)updateObject;
@end
NS_ASSUME_NONNULL_END
