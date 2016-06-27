//
//  FPImageView.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 27/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "FPImageView.h"

@implementation FPImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    CGFloat ratio = size.width/size.height;
    size.width = [UIScreen mainScreen].bounds.size.width;
    size.height = size.width / ratio;
    if (size.height <= 50) {
        size.height = 50;
    }
    return size;
}

@end
