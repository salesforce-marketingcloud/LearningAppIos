//
//  MCTagsViewController.m
//  MarketingCloud
//
//  Created by admin on 10/19/15.
//  Copyright © 2015 Oktana. All rights reserved.
//

#import "MCTagsViewController.h"
#import "ETPush.h"

@interface MCTagsViewController ()

@property(nonatomic, strong) NSArray *tags;

@end

@implementation MCTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // pushManager returns the list of tags as a NSSet collection
    NSSet *setOfTags = [[ETPush pushManager] allTags];
    // we turn that NSSet into a NSMutableArray in order to make it manipulable
    self.tags = [NSMutableArray arrayWithArray:[setOfTags allObjects]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"tagCel";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *tag = (NSString *)[self.tags objectAtIndex:indexPath.row];
    cell.textLabel.text = tag;
    return cell;
}



@end
