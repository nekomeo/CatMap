//
//  LocationManager.m
//  CatMap
//
//  Created by Elle Ti on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationManager

- (void)startLocationManager
{
    if ([CLLocationManager locationServicesEnabled])
    {
        BOOL undetermined = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined;
        BOOL authorized = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
        if (undetermined)
        {
            // request authorization
            // Then request location
            [self setupLocationManager];
            [self.locationManager requestWhenInUseAuthorization];
        }
        else if (authorized)
        {
            // request location
            [self setupLocationManager];
            [self.locationManager startUpdatingLocation];
        }
        else
        {
            // Send the user to settings to enable location updates
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location services are disabled, Please go into Settings > Privacy > Location to enable them for Play" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            [alertController addAction:ok];
            [alertController addAction:cancel];
        }
    }
}

- (void)setupLocationManager
{
    if (!self.locationManager)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways)
    {
        // User has granted permission to get their location
        [self.locationManager startUpdatingLocation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    
    NSTimeInterval locationAge = -[location.timestamp timeIntervalSinceNow];
    if (locationAge > 10.0)
    {
        return;
    }
    
    self.currentLocation = location;
    
    [self.delegate passCurrentLocation:self.currentLocation];
    
    // Call this because we called `startUpdatingLocation` earlier
    [self stopLocationManager];
}

- (void)stopLocationManager
{
    if ([CLLocationManager locationServicesEnabled])
    {
        if (self.locationManager)
        {
            [self.locationManager stopUpdatingLocation];
        }
    }
}

@end
