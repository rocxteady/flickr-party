//
//  PartiesViewController.m
//  Flickr Party
//
//  Created by Ulaş Sancak on 24/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import "PartiesViewController.h"
#import "PartyThumbCell.h"
#import "WebServiceClient.h"
#import "FlickrPhoto.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PartiesViewController () <UICollectionViewDelegateFlowLayout>
{
    NSUInteger pageNo;
    NSMutableArray *photos;
    FlickrSearchResponse *searchResponse;
    UIRefreshControl *refreshControl;
}
@end

@implementation PartiesViewController 

static NSString * const reuseIdentifier = @"PartyThumbCell";
static NSUInteger columnCount = 4;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Parties", nil);
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self setup];
    
    // Do any additional setup after loading the view.
    [self getPartyPhotos];
}

- (void)setup {
    self.collectionView.contentInset = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reset) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self.collectionView setContentOffset:CGPointMake(-refreshControl.frame.size.height, 0)];
    // Register cell classes
    [self.collectionView registerClass:[PartyThumbCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)reset {
    pageNo = 0;
    [self removeData];
    [self getPartyPhotos];
}

- (void)getPartyPhotos {
    [FlickrPhoto getPartyPhotosWithPageNo:pageNo withCompletionBlock:^(FlickrSearchResponse *response, NSError *error) {
        [refreshControl endRefreshing];
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:error.localizedDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alertView show];
        }
        else {
            searchResponse = response;
            [self insertData];
        }
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
    return photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PartyThumbCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    FlickrPhoto *photo = photos[indexPath.item];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail] placeholderImage:nil];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size;
    size.width = (collectionView.frame.size.width - collectionView.contentInset.left*(columnCount+1))/4.0;
    size.height = size.width;
    return size;
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

@end
