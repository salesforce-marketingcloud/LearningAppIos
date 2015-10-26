//
//  MCGeoLocationViewController.m
//  MarketingCloud
//
//  Created by Mathias on 10/22/15.
//  Copyright © 2015 Oktana. All rights reserved.
//
#import "MCGeoLocationViewController.h"

// Framework
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

// Libraries
#import "ETPush.h"

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
    [self drawGeofences];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self palceRegionOnMap: geofence.center
                    radius: geofence.radius
                     title: geofence.identifier];
}

/**
 Places a beacon on a map with a pin and a circle.
*/
- (void)placeBeaconOnMap:(CLBeaconRegion *)beacon {
    
    ETRegion *region = [ETRegion getBeaconRegionForRegionWithProximityUUID:[beacon.proximityUUID UUIDString]];
    
    [self palceRegionOnMap: CLLocationCoordinate2DMake([region.latitude doubleValue], [region.longitude doubleValue])
                    radius: [region.radius doubleValue]
                     title: region.regionName];
}

- (void) palceRegionOnMap:(CLLocationCoordinate2D)center radius:(CLLocationDistance) radius title:(NSString *)title {
    /**
     Add the pin
    */
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = center;
    pin.title = title;
    
    [self.mapView addAnnotation:pin];
    /**
     Add the circle
    */
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:radius];
    [self.mapView addOverlay:circle];
}

#pragma mark - <MKMapViewDelegate>

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MKCircle class]]) {
        
        MKCircleRenderer* circleRenderer    = [[MKCircleRenderer alloc]initWithOverlay:overlay];
        circleRenderer.lineWidth            = 1.0;
        circleRenderer.strokeColor          = [UIColor purpleColor];
        circleRenderer.fillColor            = [[UIColor purpleColor] colorWithAlphaComponent:0.4];
        return circleRenderer;
    }
    
    return nil;
}

@end
