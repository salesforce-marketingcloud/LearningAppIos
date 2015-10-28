//
//  MCCircle.h
//  MarketingCloud
//
//  Created by Mathias on 10/28/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MCCircle : MKCircle
@property (nonatomic, strong) UIColor *strokeColor;

+ (instancetype)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord
                                    radius:(CLLocationDistance)radius
                               strokeColor:(UIColor *)color;

@end
