//
//  FlickrPhotos.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "FlickrPhotos.h"

@implementation FlickrPhotos

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"photo": @"photos",
                                                       @"pages": @"pages",
                                                       @"perpage": @"perpage",
                                                       @"total": @"total",
                                                       @"page": @"page"
                                                       }];
}

@end
