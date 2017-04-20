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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Cart sharedInstance] setDelegate:self];
    
    products = [Cart sharedInstance].products;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.productName.text = ((Product *)products[indexPath.row]).name;
    return cell;
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
