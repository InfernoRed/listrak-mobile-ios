//
//  ListrakCartItem.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/5/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListrakItem.h"


@interface ListrakCartItem : ListrakItem

@property (nonatomic, readonly, strong) NSString *title;
@property (nonatomic, readonly, strong) NSString *imageUrl;
@property (nonatomic, readonly, strong) NSString *linkUrl;

@end