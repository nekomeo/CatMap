//
//  LocationManager.h
//  CatMap
//
//  Created by Elle Ti on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol MyLocationManagerDelegate <NSObject>

- (void)passCurrentLocation:(CLLocation *)location;

@end

@interface LocationManager : NSObject
@property (nonatomic, weak) id<MyLocationManagerDelegate> delegate;

+(id)sharedManager;
- (void)startLocationManager;
- (void)stopLocationManager;

@end
