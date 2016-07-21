//
//  NSDictionary+QueryString.m
//  FlickrParty
//
//  Created by Ulaş Sancak on 21/07/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "NSDictionary+QueryString.h"
#import "NSString+URLEncodedString.h"

@implementation NSDictionary (QueryString)

- (NSString *)queryString {
    NSString *queryString;
    for (NSString *key in self.allKeys) {
        NSString *value = self[key];
        if (![value isKindOfClass:[NSString class]]) {
            value = [NSString stringWithFormat:@"%@", value];
        }
        if (!queryString) {
            queryString = @"?";
        }
        else {
            queryString = [queryString stringByAppendingString:@"&"];
        }
        queryString = [NSString stringWithFormat:@"%@%@=%@", queryString, [NSString URLEncodedString:key], [NSString URLEncodedString:value]];
    }
    return queryString;
}

@end
