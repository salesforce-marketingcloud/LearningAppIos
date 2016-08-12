/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_3
@interface AppDelegate (ETPush) <UNUserNotificationCenterDelegate, ExactTargetCloudPageWithAlertDelegate>
#else
@interface AppDelegate (ETPush) <ExactTargetCloudPageWithAlertDelegate>
#endif

- (BOOL)application : (UIApplication *)application shouldInitETSDKWithOptions : (NSDictionary *)launchOptions;

@end
