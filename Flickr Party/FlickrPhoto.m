//
//  FlickrPhoto.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "FlickrPhoto.h"
#import "Constants.h"
#import "WebServiceClient.h"

@implementation FlickrPhoto

- (NSString<Ignore> *)thumbnail {
    return [NSString stringWithFormat:@"https://farm%lu.staticflickr.com/%@/%@_%@_s.jpg", (unsigned long)_farm, _server, _photoId, _secret];
}

- (NSString<Ignore> *)full {
    return [NSString stringWithFormat:@"https://farm%lu.staticflickr.com/%@/%@_%@.jpg", (unsigned long)_farm, _server, _photoId, _secret];
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"photoId",
                                                       @"farm": @"farm",
                                                       @"server": @"server",
                                                       @"secret": @"secret"
                                                       }];
}

+ (void)getPartyPhotosWithPageNo:(NSUInteger)pageNo withCompletionBlock:(FlickrPhotosCompletionBlock)completionBlock {
    FlickrPhotoParameters *parameters = [[FlickrPhotoParameters alloc] init];
    parameters.page = pageNo;
    parameters.perPage = 20;
    parameters.tags = @"Partyyyyy";
    [[WebServiceClient client] searchPhotosWithParameters:parameters withCompletionBlock:^(NSMutableDictionary *response, NSError *error) {
        FlickrSearchResponse *searchResponse;
        if (!error) {
            searchResponse = [[FlickrSearchResponse alloc] initWithDictionary:response error:&error];
        }
        completionBlock(searchResponse, error);
    }];
}

@end

@implementation FlickrPhotoParameters

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"page": @"page",
                                                       @"tags": @"tags",
                                                       @"per_page": @"perPage"
                                                       }];
}

@end