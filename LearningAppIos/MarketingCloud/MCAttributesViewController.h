//
//  MCAttributesViewController.h
//  MarketingCloud
//
//  Created by Tom Brooks on 1/10/17.
//  Copyright © 2017 Oktana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCAttributesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firstNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTxt;


- (IBAction)saveAttributes:(id)sender;
- (IBAction)reloadAttributes:(id)sender;

@end
