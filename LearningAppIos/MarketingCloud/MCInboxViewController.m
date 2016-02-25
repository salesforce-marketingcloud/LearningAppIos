//
//  MCInboxViewController.m
/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "MCInboxViewController.h"

// Libraries
#import "ETMessage.h"
#import "ExactTargetEnhancedPushDataSource.h"
#import "ETAnalytics.h"


@interface MCInboxViewController ()<UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *inboxTable;
@property (nonatomic, strong) ExactTargetEnhancedPushDataSource *dataSource;
@end

@implementation MCInboxViewController

- (ExactTargetEnhancedPushDataSource *) dataSource {
    if(_dataSource == nil) {
        _dataSource = [[ExactTargetEnhancedPushDataSource alloc]init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     * set delegate to table
     */
    self.inboxTable.delegate    = self;
    /**
     * set data sourse to table
     */
    self.inboxTable.dataSource  = self.dataSource;
    
    /**
     * This is a reference to the tableview in UIViewController. We need a reference to it to reload data periodically.
     */
    [self.dataSource setInboxTableView:self.inboxTable];
		[ETAnalytics trackPageView:@"data://CloudPageInboxIndex" andTitle:@"CloudPage Inbox Index" andItem:nil andSearch:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     *  Get the ETMessage object from the data source. Refer to the ETMessage.h file that is included in the SDK in order to see the available properties and methods
     */
    ETMessage *msg = [self.dataSource messages][indexPath.row];
    
    /*
     * This must be called on a message in order for it to be marked as read
     */
    [msg markAsRead];
    
    /**
     * Open unr in safary
     */
    [[UIApplication sharedApplication] openURL:msg.siteURL];
    
    /**
     * reload table
     */
    [self.inboxTable reloadData];
}

@end
