//
//  FlickrSearchResponse.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "FlickrResponse.h"
#import "FlickrPhotos.h"

@interface FlickrSearchResponse : FlickrResponse

@property (strong, nonatomic) FlickrPhotos *photos;

@end
