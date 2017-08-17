//
//  DetailViewController.h
//  CatMap
//
//  Created by Elle Ti on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flickr.h"
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic) Flickr *flickr;

- (void)addAnnotation:(id<MKAnnotation>)annotation;

@end
