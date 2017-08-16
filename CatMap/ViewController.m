//
//  ViewController.m
//  CatMap
//
//  Created by Elle Ti on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ViewController.h"
#import "Flickr.h"
#import "FlickrCollectionViewCell.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
#import "LocationManager.h"


@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MyLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *flickrArray;
@property (nonatomic, strong) LocationManager *location;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupWithTag:@"cats" withMyLocation:NO];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.location = [LocationManager sharedManager];
    self.location.delegate = self;
    [self.location startLocationManager];
}

#pragma mark - URL Request Info

- (void)setupWithTag:(NSString *)tag withMyLocation:(BOOL)shouldUseLocation
{
    self.flickrArray = [NSMutableArray array];
    
    NSString *urlString;
    
    if (shouldUseLocation)
    {
         urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=759da7ef2198dfc69eeaac5f46dd486f&tags=%@&lat=%f&lon=%f", tag, self.location.currentLocation.coordinate.latitude, self.location.currentLocation.coordinate.longitude];
    }
    
    else
    {
        urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=759da7ef2198dfc69eeaac5f46dd486f&tags=%@", tag];
    }
//    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=51fe506858b9869a0fb583d7f206ef60&tags=%@", tag];
    
//    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=51fe506858b9869a0fb583d7f206ef60&tags=%@%@", tag, self.locationTag];
    
//    NSLog(@"Url: %@", urlString);
//    
//    url = [NSURL URLWithString:urlString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSError *jsonError = nil;
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSDictionary *photoDictionary = jsonDictionary[@"photos"];
            NSMutableArray *photoArray = photoDictionary[@"photo"];
            
            [self.flickrArray removeAllObjects];
            
            for (NSDictionary *flickr in photoArray)
            {
                Flickr * image = [[Flickr alloc] initWithDictionary:flickr];
                [self.flickrArray addObject:image];
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.collectionView reloadData];
            }];
        }
    }];
    
    [dataTask resume];
}

#pragma mark - Flickr Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.flickrArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Flickr *fPhoto = self.flickrArray[indexPath.item];
    
    cell.flickrLabel.text = [fPhoto title];
    cell.flickrLabel.lineBreakMode = NSLineBreakByWordWrapping; // Word wraps title into the label
    
    NSURL *imageURL = [fPhoto imageURL];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:imageURL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIImage *someImage = [UIImage imageWithData:data];
            cell.flickrImage.image = someImage;
        }];
    }];
    
    [dataTask resume];
    
    return cell;
}

#pragma mark - Flickr Delegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetailView"])
    {
        FlickrCollectionViewCell *cell = (FlickrCollectionViewCell *)sender;
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathForCell:cell];
        
        Flickr *photo = [self.flickrArray objectAtIndex:selectedIndexPath.item];
        
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.flickr = photo;
    }
    else if ([segue.identifier isEqualToString:@"toSearch"])
    {
        SearchViewController *searchVC = (SearchViewController *)[segue destinationViewController];
        searchVC.delegate = self;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailView" sender:[self.collectionView cellForItemAtIndexPath:indexPath]];
}

#pragma mark - Flickr Map Stuff

- (void)passCurrentLocation:(CLLocation *)location
{}

- (void)newSearch:(NSString *)tag withLocation:(BOOL)shouldUseLocation
{
    [self setupWithTag:tag withMyLocation:YES];
}


@end
