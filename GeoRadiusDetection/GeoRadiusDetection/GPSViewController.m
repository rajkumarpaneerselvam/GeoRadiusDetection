//
//  GPSViewController.m
//  GeoRadiusDetection
//
//  Created by BalaBaskaran on 23/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import "GPSViewController.h"


@interface GPSViewController ()

@end

@implementation GPSViewController

@synthesize plistUtility = _plistUtility;
@synthesize geoLocationArray = _geoLocationArray;
@synthesize locationManager = _locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// inital time loading for all plist geolocation data
    self.plistUtility = [[GPSUtilitiesPlist alloc] init];
    self.geoLocationArray = [self.plistUtility getLocationData];
    
    // initialize the location manager here
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=kCLDistanceFilterNone;
    
//    Initialize the Sqlite DB
    
    sqliteHelper = [[GPSSqliteHelper alloc] init];
    [sqliteHelper initialize];
    [sqliteHelper prepareData:self.geoLocationArray];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
        [textField resignFirstResponder];
    return YES;
}

#pragma CLLocationManager Delegate method 
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    CLLocation *currentLocation = newLocation;
    
    // update the UI with user current location 
    if (currentLocation != nil) {
        self.txtLon.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.txtLat.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    NSString *imagePath = [sqliteHelper deriveZoneImage:newLocation];
    NSLog(@"Image file derived from Sqlite helper %@",imagePath);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager setDelegate:nil];
    [self.locationManager stopUpdatingLocation];
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (IBAction)locatemeAction:(id)sender {
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:40.135742 longitude:-82.992378];
    NSString *img = [sqliteHelper deriveZoneImage:loc];
    // kickstart to get user current location
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
    
    
}
@end
