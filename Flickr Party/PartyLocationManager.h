//
//  PartyLocationManager.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 27/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface PartyLocationManager : CLLocationManager

+ (instancetype)sharedManager;

@end
