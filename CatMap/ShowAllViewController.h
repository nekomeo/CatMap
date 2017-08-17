//
//  ShowAllViewController.h
//  CatMap
//
//  Created by Elle Ti on 2017-08-16.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Flickr.h"

@interface ShowAllViewController : UIViewController
@property (nonatomic, strong) NSMutableArray <Flickr *> *allPhotos;

@end
