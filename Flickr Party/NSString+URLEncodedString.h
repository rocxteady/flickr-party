//
//  NSString+URLEncodedString.h
//  FlickrParty
//
//  Created by Ulaş Sancak on 21/07/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncodedString)

+ (NSString*)URLEncodedString:(NSString *)unencodedString;

@end
