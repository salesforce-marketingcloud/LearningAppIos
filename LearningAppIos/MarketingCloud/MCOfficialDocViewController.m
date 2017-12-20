/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "MCOfficialDocViewController.h"
#import <MarketingCloudSDK/MarketingCloudSDK.h>

@interface MCOfficialDocViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *readmeWeb;

@end

@implementation MCOfficialDocViewController

- (void)viewDidLoad {
	[super viewDidLoad];
		// Do any additional setup after loading the view.
	self.navigationController.navigationBarHidden = YES;
	[self.readmeWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/"]]];
	[[MarketingCloudSDK sharedInstance] sfmc_trackPageViewWithURL:@"data://OfficialDocsLoaded" title:@"Official Docs Loaded" item:nil search:nil];

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
