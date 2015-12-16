//
//  MCOfficialDocViewController.m
//  MarketingCloud
//
//  Created by Kevin Poorman on 12/16/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import "MCOfficialDocViewController.h"

@interface MCOfficialDocViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *readmeWeb;

@end

@implementation MCOfficialDocViewController

- (void)viewDidLoad {
	[super viewDidLoad];
		// Do any additional setup after loading the view.
	self.navigationController.navigationBarHidden = YES;
	[self.readmeWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/"]]];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
