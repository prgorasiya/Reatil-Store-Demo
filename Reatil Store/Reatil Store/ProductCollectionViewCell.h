//
//  ProductCollectionViewCell.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView* productImage;
@property (nonatomic, strong) IBOutlet UILabel* productName;

@end
