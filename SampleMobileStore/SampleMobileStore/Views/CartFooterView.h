//
//  CartFooterView.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/20/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cart.h"

@interface CartFooterView : UIView

@property (strong, nonatomic) IBOutlet UIView *vwBorder;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblInstructions;
@property (strong, nonatomic) IBOutlet UIButton *btnCheckout;
@property (strong, nonatomic) IBOutlet UIButton *btnClear;

- (IBAction)checkout:(id)sender;
- (IBAction)clear:(id)sender;

@end
