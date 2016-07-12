//
//  HomeViewController.m
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import "HomeViewController.h"
#import "Constants.h"
#import "HomeCustomCell.h"
#import "ProductListViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface HomeViewController ()<SWRevealViewControllerDelegate,UISearchBarDelegate>
{
   IBOutlet UIButton *leftsideMenuButton;
    
    NSMutableArray *categoryData;
    NSMutableArray *categoryImageData;
    int productCount;
}

@end


@implementation HomeViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    ////////////// Setup for side drawer view ///////////////
    
    SWRevealViewController *revealViewController = self.revealViewController;
    self.revealViewController.delegate = self;
    
    
    if ( revealViewController )
    {
       // [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        [leftsideMenuButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchDown];
        
    }
    ////////////////////////////////////////////////////////////
    
    self.cartButton.badgeValue = [NSString stringWithFormat:@"%ld",(unsigned long)[[Cart allObjects] count]];
    self.cartButton.badgeBGColor = [UIColor orangeColor];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    categoryData = [[NSMutableArray alloc] init];
    [categoryData addObject:@"Electronics"];
    [categoryData addObject:@"Furniture"];
    
    categoryImageData = [[NSMutableArray alloc] init];
    [categoryImageData addObject:@"cat-1"];
    [categoryImageData addObject:@"cat-2"];
    
    productCount = 12;
    
    self.title = @"Retail Store";
    
    [[self.navigationController navigationBar] setTintColor:[UIColor orangeColor]];
    
    self.launchImageView.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"letter-T"],
                                 [UIImage imageNamed:@"letter-w"], nil];
    self.launchImageView.animationDuration = 5.00;
    self.launchImageView.animationRepeatCount = 0;

    [self.launchImageView startAnimating]; //start the animation
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark collection view delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [categoryData count];
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCustomCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.categoryNameLabel.text = [categoryData objectAtIndex:indexPath.row];
    cell.categoryImageView.image = [UIImage imageNamed:[categoryImageData objectAtIndex:indexPath.row]];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"productList" sender:self];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
    {
        return CGSizeMake(148, 99);
    }
    else if (IS_IPHONE_6)
    {
        return CGSizeMake(175, 125);
    }
    else if (IS_IPHONE_6P)
    {
        return CGSizeMake(190, 135);
    }
    else if (IS_IPAD)
    {
        return CGSizeMake(365, 260);
    }
 
    return CGSizeMake(139, 99);
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"productList"])
    {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        NSString *categoryName = [categoryData objectAtIndex:indexPath.item];
        
        ProductListViewController *destView = [segue destinationViewController];
        destView.categoryName = categoryName;
        destView.productCount = [NSString stringWithFormat:@"%d",productCount];
    }
    else if ([segue.identifier isEqualToString:@"productListFromSide"])
    {
        ProductListViewController *destView = [segue destinationViewController];
        destView.categoryName = [[NSUserDefaults standardUserDefaults] objectForKey:@"productListID"];
        destView.productCount = [NSString stringWithFormat:@"%d",productCount];
    }
}


#pragma mark Side Menu Delegate Methods

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if (position == FrontViewPositionLeft)
    {
        self.collectionView.userInteractionEnabled = YES;
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"productListID"])
        {
            [self performSegueWithIdentifier:@"productListFromSide" sender:self];
        }
        else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"goToCart"])
        {
            [self performSegueWithIdentifier:@"cart" sender:self];
        }
    }
    else if(position == FrontViewPositionRight)
    {
        self.collectionView.userInteractionEnabled = NO;
        [self.view endEditing:YES];
    }
}


#pragma  mark Action Methods

- (IBAction)cartButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"cart" sender:self];
}

- (IBAction)swipeLeft:(id)sender
{
    [self.revealViewController rightRevealToggleAnimated:YES];
}

- (IBAction)swipeRight:(id)sender
{
    [self.revealViewController revealToggleAnimated:YES];
}
@end
