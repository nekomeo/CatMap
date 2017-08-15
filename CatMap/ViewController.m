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


@interface ViewController () <UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *flickrArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self URLSetup];
}


#pragma mark - URL Request Info
- (void)URLSetup
{
    self.flickrArray = [NSMutableArray array];
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=759da7ef2198dfc69eeaac5f46dd486f&tags=cats"];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.flickrArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Flickr *repo = self.flickrArray[indexPath.item];
    
    cell.flickrLabel.text = [repo title];
    cell.flickrLabel.lineBreakMode = NSLineBreakByWordWrapping; // Word wraps title into the label
    
    NSURL *imageURL = [repo imageURL];
    
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


@end
