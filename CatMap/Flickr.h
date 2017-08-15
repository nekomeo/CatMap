//
//  Flickr.h
//  CatMap
//
//  Created by Elle Ti on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Flickr : NSObject
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *farm;
@property (nonatomic, strong) NSString *photoID;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *title;

@property (nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSURL *)imageURL;

@end
