//
//  CartSummaryCustomCell.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartSummaryCustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *summerySubTotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *summeryShippingLabel;
@property (strong, nonatomic) IBOutlet UILabel *summeryTotalLabel;

@property (strong, nonatomic) IBOutlet UIButton *checkOutAsGuestButton;
@property (strong, nonatomic) IBOutlet UIButton *checkoutButton;
@property (strong, nonatomic) IBOutlet UIButton *continueShoppingButton;


@end
