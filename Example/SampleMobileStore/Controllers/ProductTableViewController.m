//
//  ProductTableViewController.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/14/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "ProductTableViewController.h"

@interface ProductTableViewController ()

@end

@implementation ProductTableViewController

- (void)accountViewControllerClosed:(AccountViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cartTableViewControllerClosed:(CartTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSString *)formattedAccountName {
    Account *currentAccount = [Account sharedInstance];
    return [currentAccount isSignedIn] ? currentAccount.firstName : @"Sign In";
}


- (void)accountUserChangedNotification {
    self.navigationItem.leftBarButtonItem.title = [self formattedAccountName];
}

- (void)cartItemsChangedNotification {
    self.navigationItem.rightBarButtonItem.title = [[Cart sharedInstance] formattedCartCount];
}


- (void)loadNotificationObservers {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(accountUserChangedNotification)
     name:AccountUserChangedNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(cartItemsChangedNotification)
     name:CartItemsChangedNotification
     object:nil];
    
    [self accountUserChangedNotification];
    [self cartItemsChangedNotification];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    products = [DemoData products];
    
    [self loadNotificationObservers];
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
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    cell.lblProductName.text = ((Product *)products[indexPath.row]).name;
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        ProductDetailViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        int row = (int)[indexPath row];
        
        // Pass the selected object to the new view controller.
        detailViewController.productDetail = products[row];
    }
    else if ([segue.identifier isEqualToString:@"showCart"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        CartTableViewController *cartViewController = [navigationController viewControllers][0];
        cartViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"showAccount"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        AccountViewController *accountViewController = [navigationController viewControllers][0];
        accountViewController.delegate = self;
    }
}

@end
