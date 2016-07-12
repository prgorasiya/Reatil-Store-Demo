//
//  LeftSideTableViewController.m
//  Reatil Store
//
//  Created by Paras Gorasiya on 16/05/16.
//  Copyright © 2016 Paras Gorasiya. All rights reserved.
//

#import "LeftSideTableViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface LeftSideTableViewController ()


@property (nonatomic, strong) NSMutableArray *contents;


@end

@implementation LeftSideTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.tableView setUserInteractionEnabled:YES];
    
    if ([SharedAppDelegate.contents count]>0)
    {
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.SKSTableViewDelegate = self;
    
    // In order to expand just one cell at a time. If you set this value YES, when you expand an cell, the already-expanded cell is collapsed automatically.
    
//    self.tableView.shouldExpandOnlyOneCell = YES;
    
   
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.textLabel.text = [SharedAppDelegate.contents objectAtIndex:indexPath.row];
    
    
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    cell.imageView.image = [UIImage imageNamed:@"plus"];

    return cell;
}


- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [self.view endEditing:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:[SharedAppDelegate.contents objectAtIndex:indexPath.row] forKey:@"productListID"];
    
    [self.tableView collapseCurrentlyExpandedIndexPaths];
    [self.revealViewController revealToggleAnimated:YES];
}



- (IBAction)myCartButtonPressed:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"goToCart"];
    
    [self.tableView collapseCurrentlyExpandedIndexPaths];
    
    [self.revealViewController revealToggleAnimated:YES];
}




@end
