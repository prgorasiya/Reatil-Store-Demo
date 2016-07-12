//
//  ProductDetailViewController.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDMPhotoBrowser.h"
#import "Constants.h"

@interface ProductDetailViewController : UIViewController<IDMPhotoBrowserDelegate>

@property (strong, nonatomic) IBOutlet UIButton *cartButton;

@property (strong, nonatomic) IBOutlet UITableView *tableViewMain;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;
@property (nonatomic, strong) NSCache *imageCache;

- (IBAction)backButtonPressed:(id)sender;

@end
