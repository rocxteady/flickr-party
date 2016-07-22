//
//  ImageSessionConfiguration.h
//  TouristTracking
//
//  Created by Ulaş Sancak on 22/07/16.
//  Copyright © 2016 Metus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSessionManager : NSObject

@property (strong, nonatomic, readonly) NSURLSessionConfiguration *sessionConfiguration;
@property (strong, nonatomic, readonly) NSURLSession *session;

+ (ImageSessionManager *)sharedInstance;

@end
