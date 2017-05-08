//
//  ListrakActivity.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import "ListrakActivity.h"

@implementation ListrakActivity

+ (void)trackProductBrowseWithSku:(NSString *)sku {
    if (sku.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"sku cannot be null or empty"];
    }

    // TODO: call trackProduceBrowseWithSku in ListrakService
}

@end
