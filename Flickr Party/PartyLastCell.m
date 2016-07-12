//
//  PartyLastCell.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 24/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "PartyLastCell.h"
#import "UIColor+Utils.h"
#import "Constants.h"

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
        [self setup];
    }
    return self;
}

//Adding related subviews and creating Auto Layout constraints.
- (void)setup {
    
    self.contentView.backgroundColor = [UIColor secondColor];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.center = self.contentView.center;
    [self.contentView addSubview:activityIndicator];
    NSLayoutConstraint *verticalCenterConstraintForActivityIndicator = [NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint *horizontalCenterConstraintForActivityIndicator = [NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.contentView addConstraint:verticalCenterConstraintForActivityIndicator];
    [self.contentView addConstraint:horizontalCenterConstraintForActivityIndicator];
    [activityIndicator startAnimating];
    
    
    descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    descriptionLabel.textColor = [UIColor mainColor];
    [self.contentView addSubview:descriptionLabel];
    NSLayoutConstraint *verticalCenterConstraintForDescriptionLabel = [NSLayoutConstraint constraintWithItem:descriptionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSArray *horizontalConstraintsForDescriptionLabel = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[descriptionLabel]-%f-|", defaultViewPadding, defaultViewPadding] options:0 metrics:nil views:@{@"descriptionLabel": descriptionLabel}];
    [self.contentView addConstraints:horizontalConstraintsForDescriptionLabel];
    [self.contentView addConstraint:verticalCenterConstraintForDescriptionLabel];
    descriptionLabel.text = NSLocalizedString(@"Error. Tap here to retry.", nil);

    
    finishedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick"]];
    finishedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:finishedImageView];
    NSLayoutConstraint *horizontalCenterConstraintForFinishedImageView = [NSLayoutConstraint constraintWithItem:finishedImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *verticalCenterConstraintForFinishedImageView = [NSLayoutConstraint constraintWithItem:finishedImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.contentView addConstraint:horizontalCenterConstraintForFinishedImageView];
    [self.contentView addConstraint:verticalCenterConstraintForFinishedImageView];
    [self setPartyDataStatus:PartyDataStatusLoading];
}

//Subviews displaying arrangements considering the status of the data
- (void)setPartyDataStatus:(PartyDataStatus)partyDataStatus {
    _partyDataStatus = partyDataStatus;
    switch (partyDataStatus) {
        case PartyDataStatusLoaded:
        {
            [activityIndicator startAnimating];
            descriptionLabel.hidden = YES;
            finishedImageView.hidden = YES;
        }
            break;
        case PartyDataStatusLoading:
        {
            [activityIndicator startAnimating];
            descriptionLabel.hidden = YES;
            finishedImageView.hidden = YES;
        }
            break;
        case PartyDataStatusFinished:
        {
            [activityIndicator stopAnimating];
            descriptionLabel.hidden = YES;
            finishedImageView.hidden = NO;
        }
            break;
        case PartyDataStatusError:
        {
            [activityIndicator stopAnimating];
            descriptionLabel.hidden = NO;
            finishedImageView.hidden = YES;
        }
            break;
    }
}


@end
