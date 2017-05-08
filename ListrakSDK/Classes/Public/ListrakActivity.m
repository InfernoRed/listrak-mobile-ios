//
//  ListrakActivity.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import "ListrakActivity.h"
#import "ListrakService.h"

@implementation ListrakActivity

+ (void)trackProductBrowseWithSku:(NSString *)sku {
    if (sku.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"sku cannot be null or empty"];
    }

    [ListrakService trackProductBrowseWithSku:[NSArray arrayWithObjects:sku, nil]];
}

@end
