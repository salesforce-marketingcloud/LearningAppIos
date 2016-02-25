/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

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
