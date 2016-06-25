//
//  PartyLastCell.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 24/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "PartyLastCell.h"

@interface PartyLastCell()
{
    UILabel *descriptionLabel;
    UIActivityIndicatorView *activityIndicator;
    UIImageView *finishedImageView;
}
@end

@implementation PartyLastCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self setup];
    }
    return self;
}

- (void)setup {
    descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    descriptionLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:descriptionLabel];
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[descriptionLabel]" options:0 metrics:nil views:@{@"descriptionLabel": descriptionLabel}];
    NSLayoutConstraint *verticalCenterConstraint = [NSLayoutConstraint constraintWithItem:descriptionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *horizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:descriptionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    descriptionLabel.text = NSLocalizedString(@"S", nil);
    [self.contentView addConstraints:constraints];
    [self.contentView addConstraint:verticalCenterConstraint];
    [self.contentView addConstraint:horizontalCenterConstraint];
}

@end
