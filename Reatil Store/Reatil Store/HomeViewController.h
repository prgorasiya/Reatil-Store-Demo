//
//  HomeViewController.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *launchImageView;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIButton *cartButton;

- (IBAction)cartButtonPressed:(id)sender;

@end
