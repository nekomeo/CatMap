//
//  SearchViewController.h
//  CatMap
//
//  Created by Elle Ti on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"

@protocol SearchViewControllerDelegate <NSObject>

- (void)newSearch:(NSString *)tag withLocation:(BOOL)shouldUseLocation;
- (void)showAllWithTag:(NSString *)tag withLatitude:(float)latitude andLongitude:(float)longitude;

@end

@interface SearchViewController : UIViewController

@property (nonatomic, weak) id<SearchViewControllerDelegate> delegate;

@end
