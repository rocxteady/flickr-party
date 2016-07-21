//
//  NSString+URLEncodedString.m
//  FlickrParty
//
//  Created by Ulaş Sancak on 21/07/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "NSString+URLEncodedString.h"

@implementation NSString (URLEncodedString)

+ (NSString*)URLEncodedString:(NSString *)unencodedString
{
    CFStringRef originalStringRef = (__bridge_retained CFStringRef)unencodedString;
    NSString *s = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,originalStringRef, NULL, NULL,kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return s;
}

@end
