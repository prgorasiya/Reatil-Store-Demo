//
//  ProductCartCustomCell.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCartCustomCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *productInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *productUnitPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *productTotalPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *productQuantityLabel;
@property (strong, nonatomic) IBOutlet UIStepper *productQuantityStepper;

- (IBAction)productQuantityStepperPressed:(id)sender;


@end
