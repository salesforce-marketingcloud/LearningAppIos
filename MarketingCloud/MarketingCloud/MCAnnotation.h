//
//  MCAnnotation.h
//  MarketingCloud
//
//  Created by Mathias on 10/28/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import <UIKit/UIKit.h>
// Framework
#import <MapKit/MapKit.h>

@interface MCAnnotation : NSObject <MKAnnotation>
@property(nonatomic, copy)      NSString *image;
@property(nonatomic, assign)    CLLocationCoordinate2D coordinate;
@property(nonatomic, copy)      NSString *title;
@property(nonatomic, copy)      NSString *subtitle;

@end
