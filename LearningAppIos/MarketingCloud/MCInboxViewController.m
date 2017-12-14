//
//  MCInboxViewController.m
/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "MCInboxViewController.h"
#import <MarketingCloudSDK/MarketingCloudSDK.h>

@interface MCInboxViewController ()<UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *inboxTable;
@property (nonatomic, strong) MarketingCloudSDKInboxMessagesDataSource *dataSource;
@property (nonatomic, strong) MarketingCloudSDKInboxMessagesDelegate *delegate;
@end

@implementation MCInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    /**
     * set data sourse to table
     */
    self.dataSource = [[MarketingCloudSDKInboxMessagesDataSource alloc] initWithMarketingCloudSDK:[MarketingCloudSDK sharedInstance] tableView:self.inboxTable];

    /**
     * set delegate to table
     */
    self.delegate = [[MarketingCloudSDKInboxMessagesDelegate alloc] initWithMarketingCloudSDK:[MarketingCloudSDK sharedInstance] tableView:self.inboxTable dataSource:self.inboxTable.dataSource];

    self.inboxTable.dataSource = self.dataSource;
    self.inboxTable.delegate = self.delegate;

    /**
     * This is a reference to the tableview in UIViewController. We need a reference to it to reload data periodically.
     */
    [[MarketingCloudSDK sharedInstance] sfmc_trackPageViewWithURL:@"data://CloudPageInboxIndex" title:@"CloudPage Inbox Index" item:nil search:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
