//
//  DetailViewController.m
//  CatMap
//
//  Created by Elle Ti on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *imageCountryLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mapSetup];
    self.title = self.flickr.title;
    
    [self addAnnotation:self.flickr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapSetup
{
//    CLLocationCoordinate2D *location = 
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *redPin = @"RedPin";
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:redPin];
    
    if (!pin)
    {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:self.flickr reuseIdentifier:redPin];
        pin.pinTintColor = [UIColor redColor];
        pin.animatesDrop = YES;
    }
    return pin;
}

- (void)addAnnotation:(id<MKAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    [self.mapView showAnnotations:@[annotation] animated:YES];
}


@end
