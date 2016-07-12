//
//  PartyDetailCell.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 27/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "PartyDetailCell.h"
#import "UIColor+Utils.h"

@interface PartyDetailCell ()

{
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation PartyDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

//Adding related subviews and creating Auto Layout constraints.
- (void)setup {
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_scrollView];
    NSArray *horizontalConstraintsForScrollView= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:@{@"scrollView": _scrollView}];
    NSArray *verticalConstraintsForScrollView = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:@{@"scrollView": _scrollView}];
    [self.contentView addConstraints:horizontalConstraintsForScrollView];
    [self.contentView addConstraints:verticalConstraintsForScrollView];
    
    _imageView = [[FPImageView alloc] init];
    _imageView.backgroundColor = [UIColor blackColor];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageView];
    NSArray *horizontalConstraintsForImageView = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics:nil views:@{@"imageView": _imageView}];
    [_scrollView addConstraints:horizontalConstraintsForImageView];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:activityIndicator];
    NSLayoutConstraint *centerXConstraintForActivityIndicator = [NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *centerYConstraintForActivityIndicator = [NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [_scrollView addConstraint:centerXConstraintForActivityIndicator];
    [_scrollView addConstraint:centerYConstraintForActivityIndicator];
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionLabel.textColor = [UIColor mainColor];
    _descriptionLabel.font = [UIFont systemFontOfSize:14.0];
    [_scrollView addSubview:_descriptionLabel];
    NSArray *horizontalConstraintsForDescriptionLabel= [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[descriptionLabel]-8-|" options:0 metrics:nil views:@{@"descriptionLabel": _descriptionLabel}];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]-8-[descriptionLabel]-20-|" options:0 metrics:nil views:@{@"imageView": _imageView, @"descriptionLabel": _descriptionLabel}];
    NSLayoutConstraint *widthConstraintForDescriptionLabel = [NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-16.0];
    [_scrollView addConstraints:horizontalConstraintsForDescriptionLabel];
    [_scrollView addConstraints:verticalConstraints];
    [_scrollView addConstraint:widthConstraintForDescriptionLabel];
}

- (void)startAnimation {
    [activityIndicator startAnimating];
}

- (void)stopAnimation {
    [activityIndicator stopAnimating];
}

@end
