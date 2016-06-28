//
//  PartyLocationManager.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 27/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "PartyLocationManager.h"

static PartyLocationManager *locationManager;

@implementation PartyLocationManager

+ (instancetype)sharedManager {
    if (!locationManager) {
        locationManager = [[PartyLocationManager alloc] init];
    }
    return locationManager;
}

@end
