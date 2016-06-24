//
//  ViewControllerManager.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 24/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "ViewControllerManager.h"
#import "PartiesViewController.h"

@implementation ViewControllerManager

+ (UIViewController *)initialViewController {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 2.0;
    layout.minimumInteritemSpacing = 2.0;
    
    PartiesViewController *partiesViewController = [[PartiesViewController alloc] initWithCollectionViewLayout:layout];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:partiesViewController];
    navigationController.tabBarItem.image = [UIImage imageNamed:@"party_tab"];
    navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"party_tab"];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[navigationController];
    return tabBarController;
}

@end
