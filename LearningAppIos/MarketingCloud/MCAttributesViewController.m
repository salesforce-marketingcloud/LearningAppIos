//
//  MCAttributesViewController.m
//  MarketingCloud
//
//  Created by Tom Brooks on 1/10/17.
//  Copyright © 2017 Oktana. All rights reserved.
//

#import "MCAttributesViewController.h"
#import "AppDelegate+ETPushConstants.h"

#import <MarketingCloudSDK/MarketingCloudSDK.h>

@interface MCAttributesViewController ()

@end

@implementation MCAttributesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[[MarketingCloudSDK sfmcSDK] sfmc_attributes]];
    if([dict count] > 0)
    {
        self.firstNameTxt.text = [dict objectForKey:kPUDAttributeFirstName];
        self.lastNameTxt.text = [dict objectForKey:kPUDAttributeLastName];
    }
}

- (IBAction)saveAttributes:(id)sender {
    /**
     *  ET_NOTE: add an attribute named FirstName for this device. This attribute should first be defined inside MobilePush before being used inside the SDK
     */
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
    [dict1 setObject:self.firstNameTxt.text forKey:kPUDAttributeFirstName];
    [dict2 setObject:self.lastNameTxt.text forKey:kPUDAttributeLastName];
    NSArray *attributesArray = [[NSArray alloc] initWithObjects:dict1, dict2, nil];
    //[[MarketingCloudSDK sfmcSDK] sfmc_addAttributeNamed:kPUDAttributeLastName value:self.lastNameTxt.text];
    [[MarketingCloudSDK sfmcSDK] sfmc_addAttributes:attributesArray];
}

- (IBAction)reloadAttributes:(id)sender {
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[[MarketingCloudSDK sfmcSDK] sfmc_attributes]];
    if([dict count] > 0)
    {
        self.firstNameTxt.text = [dict objectForKey:kPUDAttributeFirstName];
        self.lastNameTxt.text = [dict objectForKey:kPUDAttributeLastName];
    }
}

@end
