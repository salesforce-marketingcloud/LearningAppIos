//
//  MarketingCloudSDK+ClientData.h
//  JB4A-SDK-iOS
//
//  Created by Brian Criscuolo on 12/1/16.
//  Copyright © 2016 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"

@interface MarketingCloudSDK (ClientData)

- (BOOL) testBaseClientData;

#pragma mark - Data Interaction
/**---------------------------------------------------------------------------------------
 * @name Data Interaction
 *  ---------------------------------------------------------------------------------------
 */

/**
 Accepts and sets the Subscriber Key for the device's user.
 
 Cannot be nil or blank.
 
 Will trim leading and trailing whitespace.
 
 @param contactKey The subscriber key to attribute to the user.
 @return YES if set successfully
 */
-(BOOL)sfmc_setContactKey:( NSString * _Nonnull )contactKey;

/**
 Returns the subscriber key for the active user, in case you need it.
 
 @return subscriberKey The code-set subscriber key.
 */
-(nullable NSString *)sfmc_contactKey;

/**
 Adds the provided Tag (NSString) to the set of unique tags.
 
 Will trim leading and trailing whitespace.
 
 Cannot be nil or blank.
 
 @param  tag A string to add to the list of tags
 @return YES if added successfully.
 */
-(BOOL)sfmc_addTag:(NSString * _Nonnull)tag;

/**
 Removes the provided Tag (NSString) from the list of tags.
 
 @param tag A string to remove from the list of tags
 @return tag Echoes the tag back on successful removal, or nil if something failed.
 */
-(nullable NSString *)sfmc_removeTag:(NSString * _Nonnull)tag;

/**
 Adds the provided Tag (NSString) to the set of unique tags.
 
 Will trim leading and trailing whitespace.
 
 Cannot be nil or blank.
 
 @param tags An array of tags to add to the list
 @return Set of tags added
 */
-(nullable NSSet *)sfmc_addTags:( NSArray * _Nonnull )tags;

/**
 Removes the provided Tag (NSString) from the list of tags.
 
 @param tags An array of tags to removed from the list
 @return Set of tags removed upon success, or nil if something failed.
 */
-(nullable NSSet *)sfmc_removeTags:( NSArray * _Nonnull )tags;

/**
 Returns the list of tags for this device.
 
 @return All tags associated.
 */
-(nullable NSSet *)sfmc_tags;


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
 */
- (BOOL)sfmc_addAttributeNamed:( NSString * _Nonnull )name value:( NSString * _Nonnull )value;

/**
 Removes the provided attribute from the data set to send to Salesforce.  The value is not changed on the SFMC.
 
 @param name The name of the attribute you wish to remove.
 @return Returns the value that was set. It will no longer be sent back to Salesforce.
 */
- (nullable NSString*)sfmc_removeAttributeNamed:( NSString * _Nonnull )name;

/**
 Returns a read-only copy of the Attributes dictionary as it is right now.
 
 @return All attributes currently set
 */
-(nullable NSDictionary *)sfmc_attributes;

/**
 Adds multiple attributes (key/value dictionaries) to Salesforce. See comments in -addAttributeNamed
 
 @param attributes An set of dictionaries of key (attribute name) and value (attribute value)
 @return A set of all attributes added
 */
- (nullable NSSet *) sfmc_addAttributes:( NSArray * _Nonnull ) attributes;

/**
 Remove multiple attributes from Salesforce. See comments in -addAttributeNamed
 
 @param attributeNames A set of attribute names
 @return A set of all attributes removed
 */
- (nullable NSSet *) sfmc_removeAttributesNamed:( NSArray * _Nonnull ) attributeNames;


@end
