//
//  FlickrPhoto.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "FlickrPhoto.h"
#import "Constants.h"

@implementation FlickrPhoto

- (NSString<Ignore> *)thumbnail {
    return [NSString stringWithFormat:@"https://farm%lu.staticflickr.com/%@/%@_%@_s.jpg", (unsigned long)_farm, _server, _photoId, _secret];
}

- (NSString<Ignore> *)full {
    return [NSString stringWithFormat:@"https://farm%lu.staticflickr.com/%@/%@_%@_s.jpg", (unsigned long)_farm, _server, _photoId, _secret];
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"photoId": @"id",
                                                       @"farm": @"farm",
                                                       @"server": @"server",
                                                       @"secret": @"secret"
                                                       }];
}

@end
