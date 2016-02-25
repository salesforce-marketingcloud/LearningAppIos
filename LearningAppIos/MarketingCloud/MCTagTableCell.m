/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

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
    [self.delegate notificationReceive: sender.on
                            indexPath: self.indexPath];
}



@end
