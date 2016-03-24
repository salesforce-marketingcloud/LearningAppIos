/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import <UIKit/UIKit.h>
// Framework
#import <MapKit/MapKit.h>

@interface MCAnnotation : NSObject <MKAnnotation>
@property(nonatomic, copy)      NSString *image;
@property(nonatomic, assign)    CLLocationCoordinate2D coordinate;
@property(nonatomic, copy)      NSString *title;
@property(nonatomic, copy)      NSString *subtitle;

@end
