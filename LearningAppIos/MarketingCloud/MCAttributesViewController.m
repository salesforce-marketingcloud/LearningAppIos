//
//  MCAttributesViewController.m
//  MarketingCloud
//
//  Created by Tom Brooks on 1/10/17.
//  Copyright © 2017 Oktana. All rights reserved.
//

#import "MCAttributesViewController.h"
#import <MarketingCloudSDK/MarketingCloudSDK.h>


@interface MCAttributesViewController ()

@end

@implementation MCAttributesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[[MarketingCloudSDK sharedInstance] sfmc_attributes]];
    if([dict count] > 0)
    {
        self.firstNameTxt.text = [dict objectForKey:@"FirstName"];
        self.lastNameTxt.text = [dict objectForKey:@"LastName"];
    }
}

- (IBAction)saveAttributes:(id)sender {
    /**
     *  ET_NOTE: add an attribute named FirstName for this device. This attribute should first be defined inside MobilePush before being used inside the SDK
     */
    [[MarketingCloudSDK sharedInstance] sfmc_setAttributeNamed:@"FirstName" value:self.firstNameTxt.text];
    [[MarketingCloudSDK sharedInstance] sfmc_setAttributeNamed:@"LastName" value:self.lastNameTxt.text];
}

- (IBAction)reloadAttributes:(id)sender {
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[[MarketingCloudSDK sharedInstance] sfmc_attributes]];
    if([dict count] > 0)
    {
        self.firstNameTxt.text = [dict objectForKey:@"FirstName"];
        self.lastNameTxt.text = [dict objectForKey:@"LastName"];
    }
}

@end
