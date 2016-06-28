//
//  Constants.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "Constants.h"

NSString *const FlickrAppKey    = @"59b7b292d9279b71ea727d76bb06f9a7";
NSString *const FlickrAppSecret = @"b7d6ff105f5e0f8b";

static Constants *constants;

@implementation Constants

+ (instancetype)sharedInstance {
    if (!constants) {
        constants = [[Constants alloc] init];
    }
    return constants;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _maincolor   = [UIColor colorWithRed:0 green:122.0/255 blue:1.0 alpha:1.0];
        _secondColor = [UIColor colorWithRed:225.0/250 green:225.0/255 blue:225.0/255 alpha:1.0];
    }
    return self;
}

@end
