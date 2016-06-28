//
//  WebServiceClientHelper.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#ifndef WebServiceClientHelper_h
#define WebServiceClientHelper_h

#import <Foundation/Foundation.h>

static NSString *const BaseURL      = @"https://api.flickr.com/services/rest";
static NSString *const SearchMethod = @"flickr.photos.search";

typedef void(^WebServiceClientCompletionBlock)(NSMutableDictionary *response, NSError *error);

typedef void(^WebServiceClientSingleCompletionBlock)(NSError *error);

#endif /* WebServiceClientHelper_h */
