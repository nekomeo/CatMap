//
//  ShowAllViewController.m
//  CatMap
//
//  Created by Elle Ti on 2017-08-16.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ShowAllViewController.h"
#import "LocationManager.h"

@interface ShowAllViewController ()// <MyLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *showAllMap;

@end

#define zoomInMapArea 2100

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.showAllMap addAnnotations:self.allPhotos];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)passCurrentLocation:(CLLocation *)location
//{
//    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
//    
//    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoomInMapArea, zoomInMapArea);
//    
//    [self.showAllMap setRegion:adjustedRegion animated:YES];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.showAllMap addAnnotations:self.allPhotos];
//    });
//}

@end
