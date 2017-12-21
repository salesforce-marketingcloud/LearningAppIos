/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "MCTagsViewController.h"
	// Libraries
#import <MarketingCloudSDK/MarketingCloudSDK.h>

	// Models
#import "MCTag.h"

	// Table cell
#import "MCTagTableCell.h"

static NSString *cellIdentifier = @"MCTagTableCell";

@interface MCTagsViewController () <MCTagTableCellDelegate>

/**
 Array of all tag object
 */
@property(nonatomic, strong) NSMutableArray *tags;

/**
 Text field, new tag name.
 */
@property (weak, nonatomic) IBOutlet UITextField *tagName;

@end

@implementation MCTagsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	/**
	 PushManager returns the list of tags as a NSSet collection
	 */
	NSSet *setOfTags = [[MarketingCloudSDK sharedInstance] sfmc_tags];
	/**
	 Init mutable array
	 */
	self.tags = [[NSMutableArray alloc]initWithCapacity:setOfTags.count];
	
	
	MCTag *tag;
	/**
	 Create object MCTag and add to tags array
	 */
	for (NSString* nameTag in [setOfTags allObjects]) {
		tag = [[MCTag alloc] init];
		tag.name    = nameTag;
		tag.on      = true;
		[self.tags addObject:tag];
	}
	[[MarketingCloudSDK sharedInstance] sfmc_trackPageViewWithURL:@"data://TagViewControllerLoaded" title:@"Tag View Loaded" item:nil search:nil];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tags count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	MCTagTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	[cell configureWithTag:self.tags[indexPath.row] indexPath:indexPath];
	cell.delegate = self;
	
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

#pragma mark - tag cell view  delegate

- (void) notificationReceive:(BOOL)recive indexPath:(NSIndexPath*)indexPath {
	MCTag *tag  = self.tags[indexPath.row];
	tag.on      = recive;
	
	/**
	 Add or remove tags for the current device.
	 */
	if (recive) {
        [[MarketingCloudSDK sharedInstance] sfmc_addTag:tag.name];
	} else {
        [[MarketingCloudSDK sharedInstance] sfmc_removeTag:tag.name];
	}
	
}
/**
 Adds a new tag to the SDK so that it is sent to the server and be able to receive push notifications.
 Reloads the table to display the tag.
 
 @param sender An ID of a component of the user interface.
 
 @return An action for the method to display in the view.
 */
- (IBAction)newTag:(id)sender {
	/**
	 Tags don't have to be defined inside of MobilePush before using them. You can create them at will.
	 Create new tag.
	 */
	MCTag *tag = [[MCTag alloc]init];
	tag.name = self.tagName.text;
	tag.on = YES;
	/**
	 Add tag in tags array
	 */
	[self.tags addObject:tag];
	
	/**
	 Add tags for the current device.
	 */
	[[MarketingCloudSDK sharedInstance] sfmc_addTag:tag.name];
	
	self.tagName.text  = @"";
	/**
	 Reload table
	 */
	[self.tableView reloadData];
}

@end
