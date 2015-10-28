//
//  MCGeoLocationViewController.m
//  MarketingCloud
//
//  Created by Mathias on 10/22/15.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//
#import "MCGeoLocationViewController.h"

// Framework
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

// Libraries
#import "ETPush.h"
#import "ETEvent.h"

// helper
#import "MCCircle.h"
#import "MCAnnotation.h"

@interface MCGeoLocationViewController () <MKMapViewDelegate>
@property (nonatomic, weak) IBOutlet UISwitch *geoLocationNotification;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@end

@implementation MCGeoLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    
    self.geoLocationNotification.on = [[ETLocationManager locationManager]getWatchingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self.mapView removeOverlays:[self.mapView overlays]];
    [self drawGeofences];
}

- (void) drawGeofences {
    /**
     Get all monitor regions.
    */
    NSArray *monitoredRegions = [[[ETLocationManager locationManager] monitoredRegions] allObjects];

    NSLog(@"monitoredRegions = %@",monitoredRegions);
    
    for (NSObject *region in monitoredRegions) {
        if([region isKindOfClass:[CLCircularRegion class]]) {
            [self placeGeofenceOnMap:(CLCircularRegion*)region];
        } else if ([region isKindOfClass:[CLBeaconRegion class]]) {
            [self placeBeaconOnMap:(CLBeaconRegion*)region];
        }
    }
}
/**
 Places a geofence on a map with a pin and a circle.
*/
- (void)placeGeofenceOnMap:(CLCircularRegion *)geofence {
    [self palceRegionOnMap:geofence.center
                    radius:geofence.radius
                     title:geofence.identifier
               strokeColor:[UIColor redColor]
                 imageName:@"annotation"];
}

/**
 Places a beacon on a map with a pin and a circle.
*/
- (void)placeBeaconOnMap:(CLBeaconRegion *)beacon {
    
    ETRegion *region = [ETRegion getBeaconRegionForRegionWithProximityUUID:[beacon.proximityUUID UUIDString]];

    [self palceRegionOnMap:CLLocationCoordinate2DMake([region.latitude doubleValue], [region.longitude doubleValue])
                    radius:[region.radius doubleValue]
                     title:region.regionName
               strokeColor:[UIColor blueColor]
                 imageName:@"beacon"];
    
}

- (void) palceRegionOnMap:(CLLocationCoordinate2D)center radius:(CLLocationDistance)radius title:(NSString *)title strokeColor:(UIColor *)color imageName:(NSString *)image {
    /**
     Add the pin
    */
    MCAnnotation *pin = [[MCAnnotation alloc] init];
    pin.coordinate = center;
    pin.title = title;
    pin.image = image;
    [self.mapView addAnnotation:pin];
    
    /**
     Add the circle
    */
    MCCircle *circle = [MCCircle circleWithCenterCoordinate:center radius:radius strokeColor:color];
    [self.mapView addOverlay:circle];
}

#pragma mark - <MKMapViewDelegate>

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MCCircle class]]) {
        
        MKCircleRenderer* circleRenderer    = [[MKCircleRenderer alloc]initWithOverlay:overlay];
        circleRenderer.lineWidth            = 1.0;
        circleRenderer.strokeColor          = ((MCCircle *)overlay).strokeColor;
        circleRenderer.fillColor            = [((MCCircle *)overlay).strokeColor colorWithAlphaComponent:0.3];
        return circleRenderer;
    }
    
    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MCAnnotation class]]) {
        static NSString * const identifier = @"MCAnnotation";
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView) {
            annotationView.annotation = annotation;
        } else {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
        }
        annotationView.image = [UIImage imageNamed:((MCAnnotation *)annotation).image];
        return annotationView;
    }
    return nil;
}

@end
