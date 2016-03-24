/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import <MapKit/MapKit.h>

@interface MCCircle : MKCircle
@property (nonatomic, strong) UIColor *strokeColor;

/**
 Creates a circle to be drawn on the map.
 
 @param coord the coordinates of the center of the circle
 @param radius distance from center of circle to the circle border
 @param color the color of the circle
 
 */

+ (instancetype)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord
                                    radius:(CLLocationDistance)radius
                               strokeColor:(UIColor *)color;

@end
