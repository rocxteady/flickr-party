//
//  WebServiceClient.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceClientHelper.h"
#import "FlickrPhoto.h"

@interface WebServiceClient : NSObject

+ (instancetype)client;

- (void)searchPhotosWithParameters:(FlickrPhotoParameters *)parameters withCompletionBlock:(WebServiceClientCompletionBlock)completionBlock;

@end
