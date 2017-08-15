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
@property (nonatomic, strong) LocationManager *location;

// Lighthouse Labs Coordinates: 49.282126, -123.108317

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.location = [[LocationManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchPost
{
    NSString *searchString = self.searchTextField.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)saveSearchButton:(UIButton *)sender
{
    [self searchPost];
    [self resignFirstResponder];
}

- (IBAction)myLocationToggle:(UISwitch *)sender
{
    if (self.myLocationToggle.enabled == YES)
    {
        [self.location startLocationManager];
    }
    else
    {
        [self.location stopLocationManager];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
