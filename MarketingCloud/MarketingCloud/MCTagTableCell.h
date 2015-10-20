//
//  MCTagTableCell.h
//  MarketingCloud
//
//  Created by Mathias on 10/19/15.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCTag;

@protocol MCTagTableCellDelegate <NSObject>

- (void) notificationRecive:(BOOL)recive indexPath:(NSIndexPath*)indexPath;

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
