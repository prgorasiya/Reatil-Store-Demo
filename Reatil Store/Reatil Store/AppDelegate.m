//
//  AppDelegate.m
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(void)addProductData
{
    RLMRealm *realm = RLMRealm.defaultRealm;
    
    [realm transactionWithBlock:^{
        
        //  Task Status Picklist
        
        Product *productObject = [[Product alloc] init];
        productObject.productIndex = @"1";
        productObject.productName = @"Samsung Microwave oven";
        productObject.productImageName = @"mo-1";
        productObject.productCategory = @"Electronics";
        productObject.productUnitPrice = 100.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        
        productObject.productIndex = @"2";
        productObject.productName = @"IFB Microwave oven";
        productObject.productImageName = @"mo-2";
        productObject.productCategory = @"Electronics";
        productObject.productUnitPrice = 150.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        
        productObject.productIndex = @"3";
        productObject.productName = @"Samsung Television";
        productObject.productImageName = @"tv-1";
        productObject.productCategory = @"Electronics";
        productObject.productUnitPrice = 100.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"4";
        productObject.productName = @"LG Television";
        productObject.productImageName = @"tv-2";
        productObject.productCategory = @"Electronics";
        productObject.productUnitPrice = 120.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"5";
        productObject.productName = @"IFB Vacuum cleaner";
        productObject.productImageName = @"vc-1";
        productObject.productCategory = @"Electronics";
        productObject.productUnitPrice = 130.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"6";
        productObject.productName = @"LG Vacuum cleaner";
        productObject.productImageName = @"vc-2";
        productObject.productCategory = @"Electronics";
        productObject.productUnitPrice = 180.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"7";
        productObject.productName = @"Wooden Table";
        productObject.productImageName = @"tb-1";
        productObject.productCategory = @"Furniture";
        productObject.productUnitPrice = 100.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"8";
        productObject.productName = @"Folding Table";
        productObject.productImageName = @"tb-2";
        productObject.productCategory = @"Furniture";
        productObject.productUnitPrice = 110.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"9";
        productObject.productName = @"Plastic Chair";
        productObject.productImageName = @"ch-1";
        productObject.productCategory = @"Furniture";
        productObject.productUnitPrice = 100.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"10";
        productObject.productName = @"Wooden Chair";
        productObject.productImageName = @"ch-2";
        productObject.productCategory = @"Furniture";
        productObject.productUnitPrice = 140.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"11";
        productObject.productName = @"Steel Almirah";
        productObject.productImageName = @"al-1";
        productObject.productCategory = @"Furniture";
        productObject.productUnitPrice = 100.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
        productObject.productIndex = @"12";
        productObject.productName = @"Wooden Almirah";
        productObject.productImageName = @"al-2";
        productObject.productCategory = @"Furniture";
        productObject.productUnitPrice = 150.0;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
    }];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        //Adding product data on first app launch
        [self addProductData];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    }
    
    self.contents = [[NSMutableArray alloc] init];
    [self.contents addObject:@"Electronics"];
    [self.contents addObject:@"Furniture"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
