//
//  UIImageView+Cache.h
//  FlickrParty
//
//  Created by Ulaş Sancak on 22/07/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIImageViewCacheCompletionBlock)(UIImage *image, BOOL isCached, NSError *error);

@interface UIImageView (Cache)

- (void)setImageWithURL:(NSURL *)URL withCompletionBlock:(UIImageViewCacheCompletionBlock)completionBlock;

- (void)cancelDownloadingURL;

@end
