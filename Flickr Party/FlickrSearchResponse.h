//
//  FlickrSearchResponse.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "FlickrResponse.h"
#import "FlickrPhotos.h"

/*

 This is the Flickr searching API response model.

*/

@class FlickrSearchResponse;

typedef void(^FlickrPhotosCompletionBlock)(FlickrSearchResponse *response, NSError *error);

@interface FlickrSearchResponse : FlickrResponse

@property (strong, nonatomic) FlickrPhotos   *photos;

@end
