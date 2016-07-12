//
//  ProductDetailViewController.m
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "productImagesTableViewCell.h"
#import "addToCartTableViewCell.h"
#import "Constants.h"


@interface ProductDetailViewController ()
{
    NSString *selectedProductID;
    NSString *selectedProductQuantity;
    
    NSString *noDataMessage;
    
    Product *currentProductObject;
    
    int noOfRowsToReturn;
}

@end


@implementation ProductDetailViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.cartButton.badgeValue = [NSString stringWithFormat:@"%ld",(unsigned long)[[Cart allObjects] count]];
    self.cartButton.badgeBGColor = [UIColor orangeColor];
    
    if ([[Cart allObjects] count] == 0)
    {
        [self.cartButton.badge setHidden:YES];
    }
    else
    {
        self.cartButton.badge.hidden = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    self.tableViewMain.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    selectedProductQuantity = @"1";
    
    noOfRowsToReturn = 2;
    
    noDataMessage = @"No Product Found.";
    
    RLMResults *prodObject = [Product objectsWhere:@"productIndex = %@", SharedAppDelegate.productIDForDetails];
    
    if (prodObject != nil)
    {
        currentProductObject = [[Product alloc] init];
        currentProductObject = [prodObject firstObject];
        
        selectedProductID = currentProductObject.productIndex;
        
        self.title = currentProductObject.productName;
    }
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



- (UIViewController *)backViewController
{
    NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
    
    if ( myIndex != 0 && myIndex != NSNotFound )
    {
        return [self.navigationController.viewControllers objectAtIndex:myIndex-1];
    }
    else
    {
        return nil;
    }
}



-(void)addToCartButtonTapped
{
    if ([Cart objectForPrimaryKey:selectedProductID])
    {
        RLMResults *results = [Cart objectsWhere:@"productIndex = %@", selectedProductID];
        
        if ([results count] > 0)
        {
            if (([[[results firstObject] valueForKey:@"productUnits"] integerValue] + [selectedProductQuantity integerValue]) > 10)
            {
                if ((10 - [[[results firstObject] valueForKey:@"productUnits"] integerValue]) > 0)
                {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"You can only add upto %lu more items", (10 - [[[results firstObject] valueForKey:@"productUnits"] integerValue])]];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"You can only add upto 10 items"];
                }
                
                return;
            }
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            Cart *product = [results firstObject];
            
            [realm transactionWithBlock:^{
                
                product.productName = currentProductObject.productName;
                NSLog(@"%ld", (long)[product.productUnits integerValue]);
                product.productUnits = [NSString stringWithFormat:@"%ld", ([product.productUnits integerValue] + 1)];
                product.productImageName = currentProductObject.productImageName;
                product.productUnitPrice = currentProductObject.productUnitPrice;
                product.productPriceForTotalUnits = [product.productUnits integerValue] * currentProductObject.productUnitPrice;
                
                [Cart createOrUpdateInDefaultRealmWithValue:product];
            }];
            
            [SVProgressHUD showSuccessWithStatus:@"Product added to cart"];
        }
    }
    else
    {
        RLMRealm *realm = [RLMRealm defaultRealm];
        Cart *product = [[Cart alloc] init];
        
        [realm transactionWithBlock:^{
            
            product.productIndex = selectedProductID;
            product.productName = currentProductObject.productName;
            product.productUnits = selectedProductQuantity;
            product.productImageName = currentProductObject.productImageName;
            product.productUnitPrice = currentProductObject.productUnitPrice;
            product.productPriceForTotalUnits = [product.productUnits integerValue] * currentProductObject.productUnitPrice;
            
            [Cart createOrUpdateInDefaultRealmWithValue:product];
        }];
        
        self.cartButton.badgeValue = [NSString stringWithFormat:@"%ld",(unsigned long)[[Cart allObjects] count]];
        self.cartButton.badgeBGColor = [UIColor orangeColor];
        
        if ([[Cart allObjects] count] == 0)
        {
            self.cartButton.badge.hidden = YES;
        }
        else
        {
            self.cartButton.badge.hidden = NO;
        }
        
        [SVProgressHUD showSuccessWithStatus:@"Product added to cart"];
        
    }
}



#pragma mark Actions

- (IBAction)backButtonPressed:(id)sender
{
    if ([self backViewController])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HomeViewController *home = [[self storyboard] instantiateViewControllerWithIdentifier:@"revealView"];
        [self.revealViewController setFrontViewController:home animated:YES];
    }
}



#pragma mark Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (noOfRowsToReturn == 0)
    {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x,[UIScreen mainScreen].bounds.size.height/2.5, [UIScreen mainScreen].bounds.size.width, 50.0)];
        
        messageLabel.text = noDataMessage;
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:20];
        
        UIImageView *messageImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x,[UIScreen mainScreen].bounds.size.height/3.0,[UIScreen mainScreen].bounds.size.width,50.0)];
        [messageImage setImage:[UIImage imageNamed:@"noproductsfound"]];
        [messageImage setContentMode:UIViewContentModeScaleAspectFit];
        
        
        UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        [msgView addSubview:messageImage];
        [msgView addSubview:messageLabel];
        
        self.tableViewMain.backgroundView = msgView;
        
    }
    else
    {
        self.tableViewMain.backgroundView = nil;
    }
    
    return noOfRowsToReturn;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Images cell
    if (indexPath.row == 0)
    {
        productImagesTableViewCell *cell = [self.tableViewMain dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
        
        cell.imageView.image = [UIImage imageNamed:currentProductObject.productImageName];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        cell.productPrice.text = [NSString stringWithFormat:@"MRP : $%.2f", currentProductObject.productUnitPrice];
        [cell.productPrice sizeToFit];
        
        cell.productName.text = [NSString stringWithFormat:@"%@", currentProductObject.productName];
        
        return cell;
    }
    //AddToCart cell
    else if (indexPath.row == 1)
    {
        addToCartTableViewCell *cell = [self.tableViewMain dequeueReusableCellWithIdentifier:@"addToCartCell" forIndexPath:indexPath];
    
        [cell.addToCartButton addTarget:self action:@selector(addToCartButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }

    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 270;
    }
    
    return 77;
}



-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font
{
    CGSize constraint = CGSizeMake([UIScreen mainScreen].bounds.size.width-90,9999); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
