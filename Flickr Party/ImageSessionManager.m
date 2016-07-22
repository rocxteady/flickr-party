//
//  ImageSessionConfiguration.m
//  TouristTracking
//
//  Created by Ulaş Sancak on 22/07/16.
//  Copyright © 2016 Metus. All rights reserved.
//

#import "ImageSessionManager.h"

@implementation ImageSessionManager

+ (ImageSessionManager *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:_sessionConfiguration delegate:nil delegateQueue:nil];
        [self setupCache];
    }
    return self;
}

- (void)setupCache {
    _sessionConfiguration.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:500*1024*1024 diskCapacity:500*1024*1024 diskPath:nil];
    [_sessionConfiguration setURLCache:cache];
}

@end
