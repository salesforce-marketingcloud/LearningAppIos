//
//  ETWKLandingPagePresenter.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 This is a helper class that shows webpages. These come down in several forms - sometimes a CloudPage, sometimes something from OpenDirect - and this guy shows them. It's a pretty simple class that pops up a view with a toolbar, shows a webpage, and waits to be dismissed.
 
 This class encapuslates a WKWebView. 
 */
@interface ETWKLandingPagePresenter : UIViewController<WKNavigationDelegate>
{
    WKWebView *_theWebView;
    UILabel *_pageTitle;
}

/**
 Don't let the name fool you - this can be *any* URL, not just a landing page. It will eventually be converted to an NSURL and displayed.
 @deprecated in __DOC_REPLACEME__
 */
@property (nonatomic, readonly, copy) NSString *landingPagePath __attribute__((deprecated("__REPLACEME__")));

/**
 A helper designated initializer that takes the landing page as a string.
 
 @param landingPage An NSString value
 @return Returns an ETWKLandingPagePresenter value
 @deprecated in __DOC_REPLACEME__
 */
-(nullable instancetype)initForLandingPageAt:(NSString *)landingPage DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

/**
 Another helper that takes it in NSURL form. We're not picky. It'd be cool of ObjC did method overloading, though.
 
 @param landingPage An NSURL value
 @return Returns an ETWKLandingPagePresenter value
 @deprecated in __DOC_REPLACEME__
 */
-(nullable instancetype)initForLandingPageAtWithURL:(NSURL *)landingPage DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__");

@end
NS_ASSUME_NONNULL_END
