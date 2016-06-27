//
//  FlickrPhoto.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "BaseModel.h"
#import "FlickrSearchResponse.h"

@interface FlickrPhoto : BaseModel

@property (strong, nonatomic) NSString *photoId;
@property (assign, nonatomic) NSUInteger farm;
@property (strong, nonatomic) NSString *server;
@property (strong, nonatomic) NSString *secret;
@property (strong, nonatomic) NSString *title;

//Ignored properties for json serialization
@property (strong, nonatomic) NSString <Ignore> *thumbnail;
@property (strong, nonatomic) NSString <Ignore> *full;

+ (void)getPartyPhotosWithPageNo:(NSUInteger)pageNo withCompletionBlock:(FlickrPhotosCompletionBlock)completionBlock;

@end

@interface FlickrPhotoParameters : BaseModel

@property (assign, nonatomic) NSUInteger perPage;
@property (assign, nonatomic) NSUInteger page;
@property (strong, nonatomic) NSString *tags;

@end
