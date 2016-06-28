//
//  BaseModel.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 23/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

#pragma mark - JSONModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
