//
//  GPSViewController.m
//  GeoRadiusDetection
//
//  Created by BalaBaskaran on 23/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import "GPSViewController.h"
#import "GeoRadiusDataModel.h"
#import "GPSCoredataManager.h"
#import "GPSImageFetcher.h"


@interface GPSViewController ()

@end

@implementation GPSViewController

@synthesize plistUtility = _plistUtility;
@synthesize geoLocationArray = _geoLocationArray;
@synthesize locationManager = _locationManager;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

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
    
    GPSCoredataManager *mgr = [[GPSCoredataManager alloc] init];
//    [mgr managedObjectContext];
    [mgr insertContentIntoCoreData];
    [mgr readContentFromCoreData];

    //    Initialize the Sqlite DB
    
    sqliteHelper = [[GPSSqliteHelper alloc] init];
    [sqliteHelper initialize];
    [sqliteHelper prepareData:self.geoLocationArray];
    
    appdel = (GPSAppDelegate *)[UIApplication sharedApplication].delegate;
    appdel.mode = @"plist";
    appdel.locationCollection = self.geoLocationArray;

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
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager setDelegate:nil];
    [self.locationManager stopUpdatingLocation];
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (IBAction)fetchLocation:(id)sender {
    // kickstart to get user current location
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
}

- (IBAction)fetchImage:(id)sender {
    NSString *lat = self.txtLat.text;
    NSString *lon = self.txtLon.text;
    UIImage *imageFound = [GPSImageFetcher imageForLocation:[[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lon doubleValue]]];
    [_bgImageView setImage:imageFound];
}



@end
