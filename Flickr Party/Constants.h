//
//  Constants.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const FlickrAppKey;
extern NSString *const FlickrAppSecret;

@interface Constants : NSObject

@property (strong, nonatomic, readonly) UIColor *maincolor;
@property (strong, nonatomic, readonly) UIColor *secondColor;

+ (instancetype)sharedInstance;

@end
