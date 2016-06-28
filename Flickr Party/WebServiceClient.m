//
//  WebServiceClient.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "WebServiceClient.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"

static WebServiceClient *client;

@interface WebServiceClient ()

{
    NSURLSessionConfiguration *configuration;
    AFURLSessionManager *manager;
}

@end

@implementation WebServiceClient

+ (instancetype)client {
    if (!client) {
        client = [[WebServiceClient alloc] init];
    }
    return client;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}

- (void)searchPhotosWithParameters:(FlickrPhotoParameters *)parameters withCompletionBlock:(WebServiceClientCompletionBlock)completionBlock{
    NSMutableDictionary *parametersDictionary;
    if (parameters) {
        parametersDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters.toDictionary];
    }
    else {
        parametersDictionary = [NSMutableDictionary dictionary];
    }
    parametersDictionary[@"method"] = SearchMethod;
    [self get:BaseURL parameters:parametersDictionary completionBlock:completionBlock];
}

- (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters completionBlock:(WebServiceClientCompletionBlock)completionBlock {
    NSMutableDictionary *parametersDictionary;
    if (parameters) {
        parametersDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }
    else {
        parametersDictionary = [NSMutableDictionary dictionary];
    }
    parametersDictionary[@"api_key"] = FlickrAppKey;
    parametersDictionary[@"format"] = @"json";
    parametersDictionary[@"nojsoncallback"] = @1;
    NSError *error = nil;
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parametersDictionary error:&error];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completionBlock(nil, error);
        } else {
            completionBlock(responseObject, nil);
        }
    }];
    [dataTask resume];
}

@end
