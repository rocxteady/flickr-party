//
//  PartyDetailViewController.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 27/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyDetailViewController : UICollectionViewController

@property (assign, nonatomic) NSUInteger photoIndex;
@property (weak, nonatomic) NSArray *photos;

@end
