//
//  FlickrPhotos.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "BaseModel.h"

@protocol FlickrPhoto
@end

@interface FlickrPhotos : BaseModel

@property (assign, nonatomic) NSUInteger page;
@property (strong, nonatomic) NSString *pages;
@property (assign, nonatomic) NSUInteger perpage;
@property (strong, nonatomic) NSString *total;
@property (strong, nonatomic) NSArray <FlickrPhoto> *photos;

@end
