//
//  SearchViewController.m
//  CatMap
//
//  Created by Elle Ti on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UISwitch *myLocationToggle;

// Lighthouse Labs Coordinates: 49.282126, -123.108317

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate newSearch:self.searchTextField.text withLocation:self.myLocationToggle.isOn];
    }];
}


@end
