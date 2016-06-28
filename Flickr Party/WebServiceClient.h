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

/**
 Start a search request to Flickr API with given parameters.
 
 @param parameters The FlickrPhotoParameters object used to create the parameters.
 @param completionBlock A block object to be executed when the request finishes.
  */
- (void)searchPhotosWithParameters:(FlickrPhotoParameters *)parameters withCompletionBlock:(WebServiceClientCompletionBlock)completionBlock;

@end
