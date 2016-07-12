//
//  RealmObjectClass.h
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import <Realm/Realm.h>

#pragma mark Product Objects

@interface Product : RLMObject
@property NSString *productIndex;
@property NSString *productName;
@property NSString *productCategory;
@property NSString *productImageName;
@property float productUnitPrice;

@end

RLM_ARRAY_TYPE(Product)


#pragma mark Product Objects

@interface Cart : RLMObject
@property NSString *productIndex;
@property NSString *productName;
@property NSString *productImageName;
@property NSString *productUnits;
@property float productUnitPrice;
@property float productPriceForTotalUnits;

@end

RLM_ARRAY_TYPE(Cart)