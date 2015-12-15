//
//  MCReadmeViewController.m
//  MarketingCloud
//
//  Created by Mathias on 10/29/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import "MCReadmeViewController.h"


@interface MCReadmeViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *readmeWeb;

@end

@implementation MCReadmeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // https://github.com/romina-oktana/marketing-cloud-SDK-iOS/blob/readme/README.md#readme
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
