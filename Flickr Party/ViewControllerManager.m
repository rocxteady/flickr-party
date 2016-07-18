//
//  ViewControllerManager.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 24/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "ViewControllerManager.h"
#import "PartiesViewController.h"
#import "PartiesNearbyViewController.h"

@implementation ViewControllerManager

+ (UIViewController *)initialViewController {
    UICollectionViewFlowLayout *layoutForParties = [[UICollectionViewFlowLayout alloc] init];
    layoutForParties.minimumLineSpacing = 2.0;
    layoutForParties.minimumInteritemSpacing = 2.0;
    
    PartiesViewController *partiesViewController = [[PartiesViewController alloc] initWithCollectionViewLayout:layoutForParties];
    UINavigationController *partiesNavigationController = [[UINavigationController alloc] initWithRootViewController:partiesViewController];
    partiesNavigationController.tabBarItem.image = [UIImage imageNamed:@"party_tab"];
    
    UICollectionViewFlowLayout *layoutForPartiesNearby = [[UICollectionViewFlowLayout alloc] init];
    layoutForPartiesNearby.minimumLineSpacing = 2.0;
    layoutForPartiesNearby.minimumInteritemSpacing = 2.0;
    PartiesNearbyViewController *partiesNearbyViewController = [[PartiesNearbyViewController alloc] initWithCollectionViewLayout:layoutForPartiesNearby];
    UINavigationController *partiesNearbyNavigationController = [[UINavigationController alloc] initWithRootViewController:partiesNearbyViewController];
    partiesNearbyNavigationController.tabBarItem.image = [UIImage imageNamed:@"nearby_tab"];
    partiesNearbyNavigationController.tabBarItem.title = NSLocalizedString(@"Parties Nearby", nil);
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[partiesNavigationController, partiesNearbyNavigationController];
    return tabBarController;
}

@end
