//
//  PartyLastCell.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 24/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PartyDataStatusLoading,
    PartyDataStatusLoaded,
    PartyDataStatusFinished,
    PartyDataStatusError
}PartyDataStatus;

@interface PartyLastCell : UICollectionViewCell

@property (assign, nonatomic) PartyDataStatus partyDataStatus;

@end
