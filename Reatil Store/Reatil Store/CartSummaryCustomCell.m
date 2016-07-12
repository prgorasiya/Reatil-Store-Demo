//
//  CartSummaryCustomCell.m
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import "CartSummaryCustomCell.h"

@implementation CartSummaryCustomCell

-(void)awakeFromNib{
    
    self.checkOutAsGuestButton.layer.cornerRadius = 5.0;
    self.checkOutAsGuestButton.layer.masksToBounds = YES;
    
    self.checkoutButton.layer.cornerRadius = 5.0;
    self.checkoutButton.layer.masksToBounds = YES;
    
    self.continueShoppingButton.layer.cornerRadius = 5.0;
    self.continueShoppingButton.layer.masksToBounds = YES;
}

@end
