//
//  RealmObjectClass.m
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import "RealmObjectClass.h"

@implementation Product

+ (NSString *)primaryKey
{
    return @"productIndex";
}

@end



@implementation Cart

+ (NSString*)primaryKey
{
    return @"productIndex";
}

@end