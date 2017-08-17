//
//  ShowAllViewController.m
//  CatMap
//
//  Created by Elle Ti on 2017-08-16.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ShowAllViewController.h"

@interface ShowAllViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *showAllMap;

@end

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

@end
