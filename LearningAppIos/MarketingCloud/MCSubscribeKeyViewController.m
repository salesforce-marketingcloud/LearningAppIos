/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "MCSubscribeKeyViewController.h"
#import <MarketingCloudSDK/MarketingCloudSDK.h>

@interface MCSubscribeKeyViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *subscriberKey;

@end

@implementation MCSubscribeKeyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
		// Do any additional setup after loading the view, typically from a nib.
	self.subscriberKey.text = [[MarketingCloudSDK sfmcSDK] sfmc_contactKey];
	[MarketingCloudSDK sfmc_trackPageView:@"data://SubscriberkeyViewLoaded" andTitle:@"Subscriber Key View Loaded" andItem:nil andSearch:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}

/**
 Uses setSubscriberKey method to save the text as the Subscriber Key.
 
 @param sender An ID of a component of the user interface.
 
 @return An action for the method to display in the view.
 */
- (IBAction)saveSubscriberKey:(id)sender {
	[[MarketingCloudSDK sfmcSDK] sfmc_setContactKey:self.subscriberKey.text];
	[MarketingCloudSDK sfmc_trackPageView:@"data://SubscriberKeySet" andTitle:@"User Set Subscriber key" andItem:nil andSearch:nil];
	
}

/**
 Uses getSubscriberKey method to get the Subscriber Key and sets it in the UITextField.
 
 @param sender An ID of a component of the user interface.
 
 @return An action for the method to display in the view.
 */
- (IBAction)reloadSubscriberKey:(id)sender {
	self.subscriberKey.text = [[MarketingCloudSDK sfmcSDK] sfmc_contactKey];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

@end
