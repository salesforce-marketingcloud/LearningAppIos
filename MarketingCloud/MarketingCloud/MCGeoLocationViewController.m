//
//  MCGeoLocationViewController.m
//  MarketingCloud
//
//  Created by Mathias on 10/22/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import "MCGeoLocationViewController.h"

// Libraries
#import "ETPush.h"

@interface MCGeoLocationViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *geoLocationNotification;

@end

@implementation MCGeoLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.geoLocationNotification.on = [[ETLocationManager locationManager]getWatchingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changedLocationNotification:(UISwitch *)sender {
    if(sender.on) {
        [[ETLocationManager locationManager]startWatchingLocation];
    } else  {
        [[ETLocationManager locationManager]stopWatchingLocation];
    }
}


@end
