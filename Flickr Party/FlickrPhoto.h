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

@property (strong, nonatomic) NSString   *photoId;
@property (assign, nonatomic) NSUInteger farm;
@property (strong, nonatomic) NSString   *server;
@property (strong, nonatomic) NSString   *secret;
@property (strong, nonatomic) NSString   *title;

//Ignored properties for json serialization
@property (strong, nonatomic) NSString <Ignore> *thumbnail;
@property (strong, nonatomic) NSString <Ignore> *full;

/**
 *  Getting photos which are tagged with "Party" using WebServiceClient.
 *
 *  @param pageNo          The page number that is wanted to get.
 *  @param completionBlock A block object to be executed when the request finishes. See the FlickrSearchResponse.h.
 */
+ (void)getPartyPhotosWithPageNo:(NSUInteger)pageNo withCompletionBlock:(FlickrPhotosCompletionBlock)completionBlock;

/**
 *  Getting photos which are tagged with "Party" close to the user using WebServiceClient.(5000 km radius)
 *
 *  @param pageNo          The page number that is wanted to get.
 *  @param completionBlock A block object to be executed when the request finishes. See the FlickrSearchResponse.h.
 */
+ (void)getPartyPhotosAroundMeWithPageNo:(NSUInteger)pageNo withCompletionBlock:(FlickrPhotosCompletionBlock)completionBlock;

@end

@interface FlickrPhotoParameters : BaseModel

@property (assign, nonatomic) NSUInteger perPage;
@property (assign, nonatomic) NSUInteger page;
@property (strong, nonatomic) NSString   *tags;
@property (strong, nonatomic) NSNumber   *lat;
@property (strong, nonatomic) NSNumber   *lon;
@property (strong, nonatomic) NSNumber   *radius;

@end
