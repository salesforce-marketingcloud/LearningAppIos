/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "NotificationService.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *modifiedNotificationContent;

@end

@implementation NotificationService

- (UNNotificationAttachment *)createMediaAttachment:(NSURL *)localMediaUrl {
    // options: specify what cropping rectangle of the media to use for a thumbnail
    //          whether the thumbnail is hidden or not
    //          which frame to use for the thumbnail if the media is a movie
    UNNotificationAttachment *mediaAttachment = [UNNotificationAttachment attachmentWithIdentifier: @"attachmentIdentifier"
                                                                                               URL: localMediaUrl
                                                                                           options: @{
                                                                                                      UNNotificationAttachmentOptionsThumbnailClippingRectKey: (NSDictionary *)CFBridgingRelease(CGRectCreateDictionaryRepresentation(CGRectZero)),
                                                                                                      UNNotificationAttachmentOptionsThumbnailHiddenKey: @NO,
                                                                                                      UNNotificationAttachmentOptionsThumbnailTimeKey: @(1)}
                                                                                             error: nil];
    return mediaAttachment;
}

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    
    // save the completion handler we will call back later
    self.contentHandler = contentHandler;
    
    // make a copy of the notification so we can change it
    self.modifiedNotificationContent = [request.content mutableCopy];
    
    // alternative text to display if there are any issues loading the media URL
    NSString *mediaAltText = request.content.userInfo[@"_mediaAlt"];
    
    // does the payload contains a remote URL to download or a local URL?
    NSString *mediaUrlString = request.content.userInfo[@"_mediaUrl"];
    NSURL *mediaUrl = [NSURL URLWithString: mediaUrlString];
    
    // if we have a URL, try to download media (i.e., https://media.giphy.com/media/3oz8xJBbCpzG9byZmU/giphy.gif)
    if (mediaUrl != nil) {
        // create a session to handle downloading of the URL
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        // start a download task to handle the download of the media
        __weak __typeof__(self) weakSelf = self;
        [[session downloadTaskWithURL:mediaUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            BOOL useAlternateText = YES;
            
            // if the download succeeded, save it locally and then make an attachment
            if (error == nil) {
                if (200 <= ((NSHTTPURLResponse*)response).statusCode  && ((NSHTTPURLResponse*)response).statusCode <= 299) {
                    // download was successful, attempt save the media file
                    NSURL *localMediaUrl = [NSURL fileURLWithPath:[location.path stringByAppendingString:mediaUrl.lastPathComponent]];
                    
                    // remove any existing file with the same name
                    [[NSFileManager defaultManager] removeItemAtURL:localMediaUrl error:nil];
                    
                    // move the downloaded file from the temporary location to a new file
                    if ([[NSFileManager defaultManager] moveItemAtURL:location toURL:localMediaUrl error:nil] == YES) {
                        // create an attachment with the new file
                        UNNotificationAttachment * mediaAttachment = [weakSelf createMediaAttachment:localMediaUrl];
                        
                        // if no problems creating the attachment, we can use it
                        if (mediaAttachment != nil) {
                            // set the media to display in the notification
                            weakSelf.modifiedNotificationContent.attachments = @[mediaAttachment];
                            
                            // everything is ok
                            useAlternateText = NO;
                        }
                    }
                }
            }
            
            // if any problems creating the attachment, use the alternate text if provided
            if ((useAlternateText == YES) && (mediaAltText != nil)) {
                weakSelf.modifiedNotificationContent.body = mediaAltText;
            }
            
            // tell the OS we are done and here is the new content
            weakSelf.contentHandler(weakSelf.modifiedNotificationContent);
        }] resume];
    }
    else {
        // see if the media URL is for a local file  (i.e., file://movie.mp4)
        BOOL useAlternateText = YES;
        if (mediaUrlString != nil) {
            // attempt to create a URL to a file in local storage
            NSURL *localMediaUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: mediaUrlString.lastPathComponent.stringByDeletingLastPathComponent ofType:mediaUrlString.pathExtension]];
            
            // is the URL a local file URL?
            if (localMediaUrl != nil && localMediaUrl.isFileURL == YES) {
                // create an attachment with the local media
                UNNotificationAttachment * mediaAttachment = [self createMediaAttachment:localMediaUrl];
                
                // if no problems creating the attachment, we can use it
                if (mediaAttachment != nil) {
                    // set the media to display in the notification
                    self.modifiedNotificationContent.attachments = @[mediaAttachment];
                    
                    // everything is ok
                    useAlternateText = NO;
                }
            }
        }
        
        // if any problems creating the attachment, use the alternate text if provided
        if ((useAlternateText == YES) && (mediaAltText != nil)) {
            self.modifiedNotificationContent.body = mediaAltText;
        }
        
        // tell the OS we are done and here is the new content
        contentHandler(self.modifiedNotificationContent);
    }
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    
    // we took too long to download the media URL, use the alternate text if provided
    NSString *mediaAltText = self.modifiedNotificationContent.userInfo[@"_mediaAlt"];
    if (mediaAltText != nil) {
        self.modifiedNotificationContent.body = mediaAltText;
    }
    
    // tell the OS we are done and here is the new content
    self.contentHandler(self.modifiedNotificationContent);
}

@end


