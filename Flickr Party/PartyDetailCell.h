//
//  PartyDetailCell.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 27/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPImageView.h"

@interface PartyDetailCell : UICollectionViewCell

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FPImageView *imageView;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
