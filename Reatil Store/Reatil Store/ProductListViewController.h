//
//  ProductListViewController.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListViewController : UIViewController

@property (nonatomic, strong) NSString* displayName;
@property (nonatomic, strong) NSString* productCount;


@property (nonatomic, strong) IBOutlet UILabel* productListLabel;

@property (nonatomic, strong) IBOutlet UICollectionView* productListCollectionView;

@property (strong, nonatomic) IBOutlet UIButton *cartButton;

@property (strong, nonatomic) NSString *categoryName;


@end
