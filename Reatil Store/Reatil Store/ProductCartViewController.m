//
//  ProductCartViewController.m
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import "ProductCartViewController.h"
#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "CartSummaryCustomCell.h"
#import "ProductCartCustomCell.h"

@interface ProductCartViewController ()
{
  float subTotal;
}
@end


@implementation ProductCartViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"productListID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"goToCart"];

    subTotal = 0;

    // Set realm notification block
    __weak typeof(self) weakSelf = self;
    self.notification = [RLMRealm.defaultRealm addNotificationBlock:^(NSString *note, RLMRealm *realm)
                         {
                             subTotal = 0;
                             
                             if (self.totalProductsInCart.count == 0)
                             {
                                 self.tableView.hidden = YES;
                             }
                             else
                             {
                                 self.tableView.hidden = NO;
                             }
                             
                             [weakSelf.tableView reloadData];
                         }];

    
    
    self.totalProductsInCart = [Cart allObjects];
    
    if (self.totalProductsInCart.count == 0)
    {
        self.tableView.hidden = YES;
    }
    else
    {
        self.tableView.hidden = NO;
    }
    
    [self.tableView reloadData];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [RLMRealm.defaultRealm removeNotification:self.notification];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)backViewController
{
    NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
    
    if ( myIndex != 0 && myIndex != NSNotFound ) {
        return [self.navigationController.viewControllers objectAtIndex:myIndex-1];
    } else {
        return nil;
    }
}


#pragma mark Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.totalProductsInCart count]+1;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Your Shopping Cart";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.totalProductsInCart count])
    {
        CartSummaryCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"orderSummaryCell" forIndexPath:indexPath];
        
        for (int i=0; i<[self.totalProductsInCart count]; i++)
        {
            Cart *productObject = [self.totalProductsInCart objectAtIndex:i];
            subTotal = subTotal+productObject.productPriceForTotalUnits;
        }
        
        cell.summerySubTotalLabel.text = [NSString stringWithFormat:@"$%.2f", subTotal];
        cell.summeryTotalLabel.text = [NSString stringWithFormat:@"$%.2f", subTotal];
        
        [cell.continueShoppingButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        
        
        return cell;
        
    }
    else
    {
        Cart *productObject = [self.totalProductsInCart objectAtIndex:indexPath.row];
        
        ProductCartCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];

        [cell.productImageView setImage:[UIImage imageNamed:productObject.productImageName]];
        
        cell.productNameLabel.text = productObject.productName;
        cell.productUnitPriceLabel.text = [NSString stringWithFormat:@"$%.2f",productObject.productUnitPrice];
        cell.productTotalPriceLabel.text = [NSString stringWithFormat:@"$%.2f",productObject.productUnitPrice];
        cell.productQuantityLabel.text = [NSString stringWithFormat:@"Qty: %@", productObject.productUnits];
        
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        
        return cell;
    }
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (!(indexPath.row == [self.totalProductsInCart count]))
    {
        Cart *productObject = [self.totalProductsInCart objectAtIndex:indexPath.row];
        SharedAppDelegate.productIDForDetails = productObject.productIndex;
        
        [self performSegueWithIdentifier:@"showDeatilFromCart" sender:nil];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.totalProductsInCart count])
    {
        return 271;
    }
    
    return 158;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.totalProductsInCart count])
    {
        return NO;
    }
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
        
            Cart *productObject = [self.totalProductsInCart objectAtIndex:indexPath.row];
            [[RLMRealm defaultRealm] deleteObject:productObject];
        }];
    }
}



#pragma  mark Actions

- (IBAction)backButtonPressed:(id)sender
{
    if ([self backViewController])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        HomeViewController *home = [[self storyboard] instantiateViewControllerWithIdentifier:@"revealView"];
        [self.revealViewController setFrontViewController:home animated:YES];
    }
}
@end
