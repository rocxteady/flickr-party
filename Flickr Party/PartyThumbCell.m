//
//  PartyThumbCell.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 24/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "PartyThumbCell.h"

@implementation PartyThumbCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

@end
