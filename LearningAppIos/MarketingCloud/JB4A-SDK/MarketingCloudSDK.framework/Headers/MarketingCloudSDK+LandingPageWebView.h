//
//  MarketingCloudSDK+LandingPageWebView.h
//  JB4A-SDK-iOS
//
//  Created by Brian Criscuolo on 12/1/16.
//  Copyright © 2016 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface MarketingCloudSDK (LandingPageWebView)

- (BOOL) testBaseLandingPage;

/**
 This is a helper class that shows webpages. These come down in several forms - sometimes a CloudPage, sometimes something from OpenDirect - and this guy shows them. It's a pretty simple class that pops up a view with a toolbar, shows a webpage, and waits to be dismissed.
 
 This class encapuslates a WKWebView.
 */

/**
 A helper designated initializer that takes the landing page as a string.
 
 @param landingPage An NSString value
 @return Returns an ETWKLandingPagePresenter value
 */
-(nullable UIViewController *)landingPageWithString:(NSString * _Nonnull)landingPage;

/**
 Another helper that takes it in NSURL form. We're not picky. It'd be cool of ObjC did method overloading, though.
 
 @param landingPage An NSURL value
 @return Returns an ETWKLandingPagePresenter value
 */
-(nullable UIViewController *)landingPageWithURL:(NSURL * _Nonnull)landingPage;

@end

