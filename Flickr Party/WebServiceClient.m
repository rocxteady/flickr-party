//
//  WebServiceClient.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "WebServiceClient.h"
#import "Constants.h"
#import "NSDictionary+QueryString.h"

@interface WebServiceClient ()

{
    NSURLSessionConfiguration *configuration;
    NSURLSession *session;
}

@end

@implementation WebServiceClient

+ (instancetype)client {
    static id client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
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
    
    NSString *queryString = [parametersDictionary queryString];
    URLString = [URLString stringByAppendingString:queryString];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:URLString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                completionBlock(nil, error);
            }
            else {
                NSError *jsonError = nil;
                NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                completionBlock(responseDictionary, nil);
            }
        });
    }];
    
    [dataTask resume];
}

@end
