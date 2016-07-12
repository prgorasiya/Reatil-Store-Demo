//
//  ProductListViewController.m
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import "ProductListViewController.h"
#import "Constants.h"
#import "ProductCollectionViewCell.h"
#import "ProductDetailViewController.h"


@interface ProductListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{    
    NSArray *products;
}


@end

@implementation ProductListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.categoryName;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"productListID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"goToCart"];
    
    products = [[NSArray alloc] init];
    
    products = [self RLMResultsToNSArray:[[Product objectsWhere:@"productCategory = %@", self.categoryName] sortedResultsUsingProperty:@"productName" ascending:YES]];
    
    [self setupUI:self.categoryName andCount:[NSString stringWithFormat:@"%lu", (unsigned long)[products count]]];
    
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
    
    [self.productListCollectionView reloadData];
}



- (void) setupUI : (NSString *) displayName andCount : (NSString *) totalData
{
    if (displayName && totalData)
    {
        UIFont *postDataFont = [UIFont systemFontOfSize:16.0];
        UIFont *postDataFontMinBold = [UIFont boldSystemFontOfSize:16.0];
        UIFont *postDataFontB = [UIFont boldSystemFontOfSize:20.0];
        NSMutableAttributedString* detailString = [[NSMutableAttributedString alloc] init];
        
        NSDictionary *headingAttrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:postDataFontB, NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
        
        NSDictionary *dataAttrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:postDataFont, NSFontAttributeName, [UIColor darkGrayColor], NSForegroundColorAttributeName, nil];
        
        NSDictionary *dataAttyDict = [NSDictionary dictionaryWithObjectsAndKeys:postDataFontMinBold, NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
        
        NSAttributedString* nameString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",displayName] attributes:headingAttrDictionary];
        
        [detailString appendAttributedString:nameString];
        
        NSAttributedString *FirstHalf = [[NSAttributedString alloc] initWithString:@"Shop from " attributes:dataAttrDictionary];
        
        [detailString appendAttributedString:FirstHalf];
        
        NSAttributedString* totalCountString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", totalData]attributes:dataAttyDict];
        
        [detailString appendAttributedString:totalCountString];
        
        NSAttributedString *SecondHalf = [[NSAttributedString alloc] initWithString:@"items for " attributes:dataAttrDictionary];
        
        [detailString appendAttributedString:SecondHalf];
        
        
        NSAttributedString *nameStringLow = [[NSAttributedString alloc] initWithString:displayName attributes:dataAttyDict];
        
        [detailString appendAttributedString:nameStringLow];
        
        
        self.productListLabel.attributedText = detailString;
        
    }
}



//Convertig RLMResults to NSArray

-(NSMutableArray*) RLMResultsToNSArray:(RLMResults*)results
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.count];
    for (RLMObject *object in results)
    {
        [array addObject:object];
    }
    return array;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - Collection View Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [products count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductCollectionViewCell *cell = [self.productListCollectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    
    cell.productImage.image = [UIImage imageNamed:[[products objectAtIndex:indexPath.row] valueForKey:@"productImageName"]];
    cell.productImage.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.productImage.layer.shadowOffset = CGSizeMake(0, 2);
    cell.productImage.layer.shadowOpacity = 1.0;
    cell.productImage.layer.shadowRadius = 5;
    cell.productImage.clipsToBounds = NO;
    
    
    UIFont *postDataFont = [UIFont systemFontOfSize:14.0];
    UIFont *postDataFontB = [UIFont systemFontOfSize:16.0];
    
    NSMutableAttributedString* detailString = [[NSMutableAttributedString alloc] init];
    
    NSDictionary *headingAttrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:postDataFontB, NSFontAttributeName, [UIColor darkGrayColor], NSForegroundColorAttributeName, nil];
    
    NSDictionary *dataAttrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:postDataFont, NSFontAttributeName, [UIColor darkGrayColor], NSForegroundColorAttributeName, nil];
    
    
    NSString *itemName = nil;
    
    if ([[products objectAtIndex:indexPath.item] valueForKey:@"productName"] && [[products objectAtIndex:indexPath.item] valueForKey:@"productName"] != nil)
    {
        itemName = [[products objectAtIndex:indexPath.item] valueForKey:@"productName"];
    }
    
    
    NSAttributedString* nameString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n", itemName] attributes:headingAttrDictionary];
    
    [detailString appendAttributedString:nameString];
    
    
    //Showing Price of the product
    if ([[products objectAtIndex:indexPath.item] valueForKey:@"productUnitPrice"])
    {
        if ([[products objectAtIndex:indexPath.item] valueForKey:@"productUnitPrice"])
        {
            NSString *listPrice = [[products objectAtIndex:indexPath.item] valueForKey:@"productUnitPrice"];
            
            NSMutableAttributedString* priceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"MRP: $%@", listPrice] attributes:dataAttrDictionary];
            
            [detailString appendAttributedString:priceString];
        }
    }
    
    cell.productName.attributedText = detailString;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SharedAppDelegate.productIDForDetails = [[products objectAtIndex:indexPath.item] valueForKey:@"productIndex"];
    [self performSegueWithIdentifier:@"productDeatil" sender:self];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark - UIcollection view layouts

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int diff = 10;
    int column = 3;
    
    if (IS_IPAD)
    {
        column = 4;
    }
  
    float widthSize = (self.view.frame.size.width - (diff* column))/(column-1);
    
    return CGSizeMake(widthSize-2, widthSize+113);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10, 10, 10, 10);
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"productDeatil"])
    {
        ProductDetailViewController* detailView = [segue destinationViewController];
    }
}




@end
