//
//  NotificationService.m
//  MarketingCloudNotificationServiceExtension
//
//  Created by Brian Criscuolo on 7/8/16.
//  Copyright © 2016 Oktana. All rights reserved.
//

#import "NotificationService.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    BOOL cat = [request.content.userInfo[@"cat"] boolValue];
    BOOL random = (request.content.userInfo[@"random"] != nil);
    if (cat == YES) {
        // Modify the notification content here...
        self.bestAttemptContent.title = @"I am a cat!";
        self.bestAttemptContent.subtitle = @"My name is Daisy";
        self.bestAttemptContent.body = @"My human walks a lot.";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"davecat" ofType:@"png"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSError *error = nil;
        NSDictionary *thumbSize = (NSDictionary *)CFBridgingRelease(CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 1, 1)));
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"davidscat" URL:fileURL options:@{UNNotificationAttachmentOptionsThumbnailClippingRectKey: thumbSize} error:&error];
        
        self.bestAttemptContent.attachments = @[attachment];
        self.contentHandler(self.bestAttemptContent);
    }
    else if (random == YES) {
        NSString *imageUrl = request.content.userInfo[@"random"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:imageUrl]
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
