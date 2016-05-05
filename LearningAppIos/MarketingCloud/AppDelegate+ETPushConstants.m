/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "AppDelegate+ETPushConstants.h"

@implementation AppDelegate (ETPushConstants)

// Code@ AppIDs and Access Tokens for the debug and production versions of your app
// These values should be stored securely by your application or retrieved from a remote server
NSString *const kETAppID_Debug                       = @"e58c6fcf-b50e-4204-8bae-6967bae907fe";// SDKX @"995b5b1a-162c-4e5d-a4cf-ac5ddeb14e47";//la @"e58c6fcf-b50e-4204-8bae-6967bae907fe";//orig @"d6684160-1bb0-4598-b6bf-23c43bc279a2";
NSString *const kETAccessToken_Debug                 = @"wjsenz99hfbeqgd7fugt6zj3";//SDKX @"cyg6ftcd8sbqetq7wy5v7ez3";//la @"wjsenz99hfbeqgd7fugt6zj3";//orig @"fdyervvwyar4zfuqf8776rwq";
NSString *const kETAppID_Prod                        = @"e58c6fcf-b50e-4204-8bae-6967bae907fe";
NSString *const kETAccessToken_Prod                  = @"wjsenz99hfbeqgd7fugt6zj3";

// Constants used for Strings
NSString *const kMessageTypeLocation                 = @"Location";
NSString *const kUserDefaultsLastPushReceivedDate    = @"ud_lastPushReceivedDate";
NSString *const kUserDefaultsPushUserInfo            = @"ud_pushUserInfo";
NSString *const kUserDefaultsMessageType             = @"ud_messageType";
NSString *const kUserDefaultsAlertText               = @"ud_alertText";
NSString *const kMessageDetailCustomKeyDiscountCode  = @"discount_code";
NSString *const kPushDefineOpenDirectPayloadKey      = @"_od";
NSString *const kPushDefineCloudPagePayloadKey       = @"_x";
NSString *const kPushDefinePersistentNotificationKey = @"_p";

@end
