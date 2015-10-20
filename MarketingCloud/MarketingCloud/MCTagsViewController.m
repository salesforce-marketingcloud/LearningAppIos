//
//  MCTagsViewController.m
//  MarketingCloud
//
//  Created by admin on 10/19/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import "MCTagsViewController.h"

// Libraries
#import "ETPush.h"

// Models
#import "MCTag.h"

// Table cell
#import "MCTagTableCell.h"

static NSString *cellIdentifier = @"MCTagTableCell";

@interface MCTagsViewController () <MCTagTableCellDelegate>

/**
 Array all tag object
 */
@property(nonatomic, strong) NSMutableArray *tags;

/**
 Text field. name nuew tag
 */
@property (weak, nonatomic) IBOutlet UITextField *tagName;

@end

@implementation MCTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // pushManager returns the list of tags as a NSSet collection
    NSSet *setOfTags = [[ETPush pushManager] allTags];
    
    // init mutable array
    self.tags = [[NSMutableArray alloc]initWithCapacity:setOfTags.count];
    
    
    MCTag *tag;
    
    // created object MCTag and add in tags array
    for (NSString* nameTag in [setOfTags allObjects]) {
        tag = [[MCTag alloc] init];
        tag.name    = nameTag;
        tag.on      = true;
        [self.tags addObject:tag];
    }
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

#pragma mark - tag cell view  delegate

- (void) notificationRecive:(BOOL)recive indexPath:(NSIndexPath*)indexPath {
    MCTag *tag  = self.tags[indexPath.row];
    tag.on      = recive;
    
    /**
      Add or remove tags for the current device.
     */
    if (recive) {
        [[ETPush pushManager] addTag:tag.name];
    } else {
        [[ETPush pushManager] removeTag:tag.name];
    }
    
}

- (IBAction)newTag:(id)sender {
    /**
     Tags don't have to be defined inside of MobilePush before using them. You can create them at will
     Create new tag
     */
    MCTag *tag = [[MCTag alloc]init];
    tag.name = self.tagName.text;
    tag.on = YES;
    
    // add tag in tags array
    [self.tags addObject:tag];
    
    // add tafs for the current device.
    [[ETPush pushManager] addTag:tag.name];
    
    self.tagName.text  = @"";
    
    // reload table
    [self.tableView reloadData];
}

@end
