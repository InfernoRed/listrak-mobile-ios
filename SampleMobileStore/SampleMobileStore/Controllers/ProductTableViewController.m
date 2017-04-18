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

- (void)processItemsChanged;
{
    self.navigationItem.rightBarButtonItem.title = [[Cart sharedInstance] formattedCartCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Cart sharedInstance] setDelegate:self];
    
    products = [DemoData products];
    
    [[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign In" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:[[Cart sharedInstance] formattedCartCount]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:nil];
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
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    cell.productName.text = ((Product *)products[indexPath.row]).name;
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        // Get the new view controller using [segue destinationViewController].
        ProductDetailViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        int row = (int)[indexPath row];
        
        // Pass the selected object to the new view controller.
        detailViewController.productDetail = products[row];
    }
}


@end
