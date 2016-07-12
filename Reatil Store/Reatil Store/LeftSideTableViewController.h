//
//  LeftSideTableViewController.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "SKSTableView.h"

@interface LeftSideTableViewController : UIViewController<SKSTableViewDelegate>

@property (strong, nonatomic) RLMResults *notificationResult;

@property (nonatomic, weak) IBOutlet SKSTableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *myCartButton;

- (IBAction)myCartButtonPressed:(id)sender;


@end
