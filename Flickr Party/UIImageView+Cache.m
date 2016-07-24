//
//  UIImageView+Cache.m
//  FlickrParty
//
//  Created by Ulaş Sancak on 22/07/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "WebServiceClient.h"
#import <objc/runtime.h>

@interface UIImageView () <NSURLSessionDataDelegate>

@property (strong, nonatomic) NSURLSessionDataTask *downloadTask;

@end

@implementation UIImageView (Cache)

- (void)setDownloadTask:(NSURLSessionDataTask *)downloadTask {
    objc_setAssociatedObject(self, @selector(downloadTask), downloadTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURLSessionDataTask *)downloadTask {
    return objc_getAssociatedObject(self, @selector(downloadTask));
}

- (void)setImageWithURL:(NSURL *)URL withCompletionBlock:(UIImageViewCacheCompletionBlock)completionBlock{
    NSURLSession *session = [WebServiceClient client].session;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSCachedURLResponse *cachedResponse = [[WebServiceClient client].sessionConfiguration.URLCache cachedResponseForRequest:request];
        if (cachedResponse) {
            UIImage *image = [UIImage imageWithData:cachedResponse.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(image, YES, nil);
            });
        }
        else {
            self.downloadTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionBlock(image, NO, nil);
                    });
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionBlock(nil, NO, error);
                    });
                }
                self.downloadTask = nil;
            }];
            [self.downloadTask resume];
        }
    });
}

- (void)cancelDownloadingURL {
    if (self.downloadTask) {
        [self.downloadTask cancel];
        self.downloadTask = nil;
    }
}

@end
