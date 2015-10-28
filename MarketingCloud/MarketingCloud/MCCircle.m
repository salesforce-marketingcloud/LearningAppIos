//
//  MCCircle.m
//  MarketingCloud
//
//  Created by Mathias on 10/28/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import "MCCircle.h"

@implementation MCCircle

+ (instancetype)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord
                                    radius:(CLLocationDistance)radius
                               strokeColor:(UIColor *)color {
    
    MCCircle *circle;
    if ((circle = [super circleWithCenterCoordinate:coord radius:radius]) ) {
        circle.strokeColor = color;
    }
    return circle;
}

@end
