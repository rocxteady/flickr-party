//
//  PartiesNearbyViewController.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 27/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "PartiesNearbyViewController.h"
#import "PartyThumbCell.h"
#import "PartyLastCell.h"
#import "WebServiceClient.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PartyDetailViewController.h"
#import "UIColor+Utils.h"
#import "PartyLocationManager.h"

@interface PartiesNearbyViewController () <UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate, UIAlertViewDelegate>
{
    NSUInteger pageNo;
    NSMutableArray *photos;
    FlickrSearchResponse *searchResponse;
    UIRefreshControl *refreshControl;
    PartyLocationManager *locationManager;
    BOOL isLocationAuthorizationErrorDisplayed;
}

@property (assign, nonatomic) PartyDataStatus partyDataStatus;

@end

@implementation PartiesNearbyViewController

static NSString * const defaultReuseIdentifier = @"PartyThumbCell";
static NSString * const lastCellReuseIdentifier = @"PartyLastCell";
static NSUInteger columnCount = 4;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Parties";
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self setup];
    
    // Do any additional setup after loading the view.
    [self reset];

    self.title = @"Parties Nearby";
    
}

#pragma mark <CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.partyDataStatus = PartyDataStatusError;
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:photos.count inSection:0]]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"%@", locations);
    [locationManager stopUpdatingLocation];
    [self getPartyPhotos];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSString *errorDescription;
    if (status == kCLAuthorizationStatusDenied) {
        errorDescription = @"You must give location permission to access this feature.";

    }
    else if (status == kCLAuthorizationStatusRestricted) {
        errorDescription = @"Location access is restricted!";

    }
    //If the status == kCLAuthorizationStatusDenied or kCLAuthorizationStatusRestricted while browsing, we let user browsing for his/her latest location. Otherwise error occurs.
    if (errorDescription && pageNo == 1) {
        if (!isLocationAuthorizationErrorDisplayed) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            isLocationAuthorizationErrorDisplayed = YES;
        }
        self.partyDataStatus = PartyDataStatusError;
        [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:photos.count inSection:0]]];
    }
}

#pragma mark - UI Setup

- (void)setup {
    //UI arrangements.
    self.collectionView.contentInset = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor secondColor];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reset) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    // Register cell classes
    [self.collectionView registerClass:[PartyThumbCell class] forCellWithReuseIdentifier:defaultReuseIdentifier];
    [self.collectionView registerClass:[PartyLastCell class] forCellWithReuseIdentifier:lastCellReuseIdentifier];
}

- (void)reset {
    self.partyDataStatus = PartyDataStatusLoading;
    pageNo = 1;
    [self removeData];
    locationManager = [PartyLocationManager sharedManager];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
         [locationManager requestWhenInUseAuthorization];
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    NSString *errorDescription = nil;
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            
            break;
        case kCLAuthorizationStatusDenied:
            errorDescription = @"You must give location permission to access this feature.";
            break;
        case kCLAuthorizationStatusRestricted:
            errorDescription = @"Location access is restricted!";
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
        default:
            break;
    }
    if (errorDescription) {
        if (!isLocationAuthorizationErrorDisplayed) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            isLocationAuthorizationErrorDisplayed = YES;
        }
        self.partyDataStatus = PartyDataStatusError;
    }
    else {
        [locationManager startUpdatingLocation];
    }
}

#pragma mark - Party Data Methods

- (void)getPartyPhotos {
    self.partyDataStatus = PartyDataStatusLoading;
    [FlickrPhoto getPartyPhotosAroundMeWithPageNo:pageNo withCompletionBlock:^(FlickrSearchResponse *response, NSError *error) {
        [refreshControl endRefreshing];
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            self.partyDataStatus = PartyDataStatusError;
        }
        else {
            ++pageNo;
            searchResponse = response;
            [self insertData];
            if (pageNo > searchResponse.photos.pages) {
                self.partyDataStatus = PartyDataStatusFinished;
            }
            else {
                self.partyDataStatus = PartyDataStatusLoaded;
            }
            
        }
        [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:photos.count inSection:0]]];
    }];
}

- (void)insertData {
    if (!photos) {
        photos = [NSMutableArray array];
    }
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger i = photos.count; i < photos.count + searchResponse.photos.photos.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    [photos addObjectsFromArray:searchResponse.photos.photos];
    [self.collectionView insertItemsAtIndexPaths:indexPaths];
}

- (void)removeData {
    if (!photos) {
        return;
    }
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSUInteger i = 0; i < photos.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    [photos removeAllObjects];
    [self.collectionView deleteItemsAtIndexPaths:indexPaths];
}

- (void)setPartyDataStatus:(PartyDataStatus)partyDataStatus {
    if (partyDataStatus == PartyDataStatusError) {
        [refreshControl endRefreshing];
    }
    _partyDataStatus = partyDataStatus;
    PartyLastCell *cell = (PartyLastCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:photos.count inSection:0]];
    cell.partyDataStatus = partyDataStatus;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return photos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == photos.count) {
        PartyLastCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lastCellReuseIdentifier forIndexPath:indexPath];
        cell.partyDataStatus = self.partyDataStatus;
        switch (cell.partyDataStatus) {
            case PartyDataStatusLoaded:
                [self getPartyPhotos];
                break;
            case PartyDataStatusLoading:
                
                break;
            case PartyDataStatusFinished:
                
                break;
            case PartyDataStatusError:
                
                break;
            default:
                break;
        }
        return cell;
    }
    PartyThumbCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:defaultReuseIdentifier forIndexPath:indexPath];
    cell.imageView.alpha = 0;
    // Configure the cell
    FlickrPhoto *photo = photos[indexPath.item];
    __block __weak PartyThumbCell *blockCell = cell;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType == SDImageCacheTypeNone) {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 blockCell.imageView.alpha = 1.0;
                             }];
        }
        else {
            blockCell.imageView.alpha = 1.0;
        }
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == photos.count) {
        CGSize size = CGSizeMake(collectionView.frame.size.width - collectionView.contentInset.left*2, 44.0);
        return size;
    }
    CGSize size;
    size.width = (collectionView.frame.size.width - collectionView.contentInset.left*(columnCount+1))/4.0;
    size.height = size.width;
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == photos.count) {
        PartyLastCell *cell = (PartyLastCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell.partyDataStatus == PartyDataStatusError) {
            //If it is the first page, we call the reset function in order to refresh location manager.
            if (pageNo == 1) {
                [self reset];
            }
            else {
               [self getPartyPhotos];
            }
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
    }
    else {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        PartyDetailViewController *partyDetailViewController = [[PartyDetailViewController alloc] initWithCollectionViewLayout:layout];
        partyDetailViewController.photoIndex = indexPath.item;
        partyDetailViewController.photos = photos;
        [self.navigationController pushViewController:partyDetailViewController animated:YES];
    }
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

#pragma mark - UIAlertView Delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    isLocationAuthorizationErrorDisplayed = NO;
}

@end
