//
//  MCCircle.h
//  MarketingCloud
//
//  Created by Mathias on 10/28/15.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

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
