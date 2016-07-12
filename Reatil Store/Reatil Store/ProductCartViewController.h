//
//  ProductCartViewController.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ProductCartViewController : UIViewController

@property (nonatomic, strong) RLMResults *totalProductsInCart;
@property (nonatomic, strong) RLMNotificationToken *notification;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
- (IBAction)backButtonPressed:(id)sender;

@end
