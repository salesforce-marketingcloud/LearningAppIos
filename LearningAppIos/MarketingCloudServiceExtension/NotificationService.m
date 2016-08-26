//
//  NotificationService.m
//  MarketingCloudServiceExtension
//
//  Created by Brian Criscuolo on 8/26/16.
//  Copyright © 2016 Oktana. All rights reserved.
//

#import "NotificationService.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

/*
 
 Imagine sending this payload:
 
 {
 "aps": {
 "alert": {
 "title": "BAM",
 "body": "look at that!"
 },
 "badge": 1,
 "mutable-content": 1
 },
 "imageURL":"https://i.giphy.com/o9ggk5IMcYlKE.gif"
 }
 
 This service extension will download the file at imageURL locally and present it as the notification content
 */

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    self.bestAttemptContent.title = @"BAM!";

    NSString *imageURL = request.content.userInfo[@"imageURL"];
    if (imageURL != nil) {
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:imageURL]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsPath = [paths objectAtIndex:0];
                    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.gif"];
                    BOOL writeSuccess = [data writeToFile:filePath atomically:YES];
                    if (writeSuccess == YES) {
                        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
                        
                        NSError *error2 = nil;
                        NSDictionary *thumbSize = (NSDictionary *)CFBridgingRelease(CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 1, 1)));
                        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"" URL:fileURL options:@{UNNotificationAttachmentOptionsThumbnailClippingRectKey: thumbSize} error:&error2];
                        self.bestAttemptContent.attachments = @[attachment];
                        
                        self.contentHandler(self.bestAttemptContent);
                    }
                    
                }] resume];
    }
    else {
        self.contentHandler(self.bestAttemptContent);
    }
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
