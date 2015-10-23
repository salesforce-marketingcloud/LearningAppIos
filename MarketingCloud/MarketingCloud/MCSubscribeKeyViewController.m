//
//  MCHomeView.m
//  MarketingCloud
//
//  Created by Mathias on 10/16/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import "MCHomeView.h"

#import "ETPush.h" // From the SDK

@interface MCHomeView ()
@property (weak, nonatomic) IBOutlet UITextField *subscriberKey;

@end

@implementation MCHomeView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // The getSubscriberKey() method returns the value
    // The getSubscriberKey() method retrieves only the local copy of the value and not the value from the Salesforce Marketing Cloud.
    self.subscriberKey.text = [[ETPush pushManager] getSubscriberKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveSubscriberKey:(id)sender {
    
    // Use setSubscriberKey() to implement a specific value as the unique identifier for the contact.
    // You can use a mobile number, email address, device ID, or other appropriate value as necessary.
    [[ETPush pushManager] setSubscriberKey:self.subscriberKey.text];
}

- (IBAction)reloadSubscriberKey:(id)sender {
    // The getSubscriberKey() method returns the value
    // The getSubscriberKey() method retrieves only the local copy of the value and not the value from the Salesforce Marketing Cloud.
    self.subscriberKey.text = [[ETPush pushManager] getSubscriberKey];
}

@end