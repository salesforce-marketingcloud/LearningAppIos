	//
	//  MCHomeView.m
	//  MarketingCloud
	//
	//  Created by Mathias on 10/16/15.
	//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
	//

#import "MCSubscribeKeyViewController.h"

#import "ETPush.h" // From the SDK
#import "ETAnalytics.h"

@interface MCSubscribeKeyViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *subscriberKey;

@end

@implementation MCSubscribeKeyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
		// Do any additional setup after loading the view, typically from a nib.
	self.subscriberKey.text = [[ETPush pushManager] getSubscriberKey];
	[ETAnalytics trackPageView:@"data://SubscriberkeyViewLoaded" andTitle:@"Subscriber Key View Loaded" andItem:nil andSearch:nil];
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
	[[ETPush pushManager] setSubscriberKey:self.subscriberKey.text];
	[ETAnalytics trackPageView:@"data://SubscriberKeySet" andTitle:@"User Set Subscriber key" andItem:nil andSearch:nil];
	
}

/**
 Uses getSubscriberKey method to get the Subscriber Key and sets it in the UITextField.
 
 @param sender An ID of a component of the user interface.
 
 @return An action for the method to display in the view.
 */
- (IBAction)reloadSubscriberKey:(id)sender {
	self.subscriberKey.text = [[ETPush pushManager] getSubscriberKey];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

@end