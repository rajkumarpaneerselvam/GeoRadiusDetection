//
//  GPSViewController.h
//  GeoRadiusDetection
//
//  Created by BalaBaskaran on 23/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSUtilitiesPlist.h"
#import <CoreLocation/CoreLocation.h>


@interface GPSViewController : UIViewController <CLLocationManagerDelegate> {
    
}

@property (strong, nonatomic) GPSUtilitiesPlist *plistUtility;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITextField *txtLat;

@property (weak, nonatomic) IBOutlet UITextField *txtLon;

@property (weak, nonatomic) IBOutlet UIButton *btnSelector;
@property (weak, nonatomic) IBOutlet UIButton *btnLocateMe;
@property (weak, nonatomic) IBOutlet UIButton *btnLocate;



@property (strong, nonatomic) NSMutableArray *geoLocationArray;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;



- (IBAction)locatemeAction:(id)sender;

@end
