//
//  MCTagTableCell.m
//  MarketingCloud
//
//  Created by Mathias on 10/19/15.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "MCTagTableCell.h"

// Models
#import "MCTag.h"

@interface MCTagTableCell ()
@property(nonatomic, strong)NSIndexPath *indexPath;

@end

@implementation MCTagTableCell


- (void)configureWithTag:(MCTag *)tag indexPath:(NSIndexPath *)indexPath {
    /**
     Cell defaults
     */
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType  = UITableViewCellAccessoryNone;
    
    self.indexPath              = indexPath;
    self.titleLabel.text        = tag.name;
    self.notificationSwitch.on  = tag.on;
}

- (IBAction)norificationSwichChanged:(UISwitch *)sender {
    [self.delegate notificationRecive: sender.on
                            indexPath: self.indexPath];
}



@end
