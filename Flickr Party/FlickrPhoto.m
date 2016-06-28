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
#import "PartyLocationManager.h"

@implementation FlickrPhoto

#pragma mark - JSONModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"photoId",
                                                       @"farm": @"farm",
                                                       @"server": @"server",
                                                       @"secret": @"secret",
                                                       @"title": @"title"
                                                       }];
}

#pragma mark - Unserialized Getters
//Generating thumbnail and full URL strings for the photos
- (NSString<Ignore> *)thumbnail {
    return [NSString stringWithFormat:@"https://farm%lu.staticflickr.com/%@/%@_%@_s.jpg", (unsigned long)_farm, _server, _photoId, _secret];
}

- (NSString<Ignore> *)full {
    return [NSString stringWithFormat:@"https://farm%lu.staticflickr.com/%@/%@_%@.jpg", (unsigned long)_farm, _server, _photoId, _secret];
}

#pragma mark - Party Requests
+ (void)getPartyPhotosWithPageNo:(NSUInteger)pageNo withCompletionBlock:(FlickrPhotosCompletionBlock)completionBlock {
    FlickrPhotoParameters *parameters = [[FlickrPhotoParameters alloc] init];
    parameters.page = pageNo;
    parameters.perPage = 32;
    parameters.tags = @"Party";
    [[WebServiceClient client] searchPhotosWithParameters:parameters withCompletionBlock:^(NSMutableDictionary *response, NSError *error) {
        FlickrSearchResponse *searchResponse;
        if (!error) {
            searchResponse = [[FlickrSearchResponse alloc] initWithDictionary:response error:&error];
        }
        completionBlock(searchResponse, error);
    }];
}

+ (void)getPartyPhotosAroundMeWithPageNo:(NSUInteger)pageNo withCompletionBlock:(FlickrPhotosCompletionBlock)completionBlock {
    FlickrPhotoParameters *parameters = [[FlickrPhotoParameters alloc] init];
    parameters.page = pageNo;
    parameters.perPage = 32;
    parameters.tags = @"Party";
    parameters.lat = @([PartyLocationManager sharedManager].location.coordinate.latitude);
    parameters.lon = @([PartyLocationManager sharedManager].location.coordinate.longitude);
    parameters.radius = @5;
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
                                                       @"per_page": @"perPage",
                                                       @"lat": @"lat",
                                                       @"lon": @"lon",
                                                       @"radius": @"radius"
                                                       }];
}

@end