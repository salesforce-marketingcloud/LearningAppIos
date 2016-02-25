/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "AppDelegate.h"

@interface AppDelegate (ETPushConstants)


// Debug Application ID
FOUNDATION_EXPORT NSString *const kETAppID_Debug;
// Debug Access Token
FOUNDATION_EXPORT NSString *const kETAccessToken_Debug;
// Production Application ID
FOUNDATION_EXPORT NSString *const kETAppID_Prod;
// Production Access Token
FOUNDATION_EXPORT NSString *const kETAccessToken_Prod;

FOUNDATION_EXPORT NSString *const kMessageTypeLocation;
FOUNDATION_EXPORT NSString *const kUserDefaultsLastPushReceivedDate;
FOUNDATION_EXPORT NSString *const kUserDefaultsPushUserInfo;
FOUNDATION_EXPORT NSString *const kUserDefaultsMessageType;
FOUNDATION_EXPORT NSString *const kUserDefaultsAlertText;
FOUNDATION_EXPORT NSString *const kMessageDetailCustomKeyDiscountCode;
FOUNDATION_EXPORT NSString *const kPushDefineOpenDirectPayloadKey;
FOUNDATION_EXPORT NSString *const kPushDefineCloudPagePayloadKey;
FOUNDATION_EXPORT NSString *const kPushDefinePersistentNotificationKey;

@end
