/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import <UIKit/UIKit.h>

@class MCTag;

@protocol MCTagTableCellDelegate <NSObject>

/** 
 Executes when a tag changes state, true or false
 
 @param receive The state of the tag, true or false
 @param indexPath The position of the cell in the table
 */
- (void) notificationReceive:(BOOL)receive indexPath:(NSIndexPath*)indexPath;

@end


@interface MCTagTableCell : UITableViewCell

/**
 Delegate for the cell
 */
@property (nonatomic, weak) id<MCTagTableCellDelegate> delegate;

/**
 Displays title of current setting
 */
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

/**
 Allows user to turn notifications on or off
 */
@property (nonatomic, strong) IBOutlet UISwitch *notificationSwitch;

/**
 Sets up the cell view using the tag present in the MCTag object
 
 @param tag The MCTag containing the data that should be displayed in the cell.
 @param indexPath The indexPath of the cell that is being configured.
 */
- (void)configureWithTag:(MCTag *)tag indexPath:(NSIndexPath *)indexPath;

@end
