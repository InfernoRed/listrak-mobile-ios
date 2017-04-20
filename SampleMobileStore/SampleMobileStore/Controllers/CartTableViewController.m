//
//  CartTableViewController.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/19/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "CartTableViewController.h"

@interface CartTableViewController ()

@end

@implementation CartTableViewController

- (IBAction)close:(id)sender;
{
    [self.delegate cartTableViewControllerClosed:self];
}


- (void)cartItemsChangedNotification;
{
    products = [Cart sharedInstance].products;
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(cartItemsChangedNotification)
     name:CartItemsChangedNotification
     object:nil];

    products = [Cart sharedInstance].products;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    cell.lblProductName.text = ((Product *)products[indexPath.row]).name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id product = products[indexPath.row];
    
    id alert = [UIAlertController alertControllerWithTitle:@"Remove Item" message:@"Would you like to remove this item from the shopping cart?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Yes"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction *action) {
                                                [[Cart sharedInstance] removeProduct:product];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
