//
//  GPSUtilitiesPlist.m
//  GeoRadiusDetection
//
//  Created by Latchumanan, Balabaskaran on 1/24/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import "GPSUtilitiesPlist.h"
#import "GPSLocationData.h"

#define kTitle @"title"
#define kImage @"image"
#define kLat @"lat"
#define kLong @"lon"
#define kRadius @"radius"

@implementation GPSUtilitiesPlist


- (NSMutableArray *)getLocationData {
    //Load Dictionary with all location data info
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"LocationData" ofType:@"plist"];
    NSMutableArray *locDataArray = [[NSMutableArray alloc] initWithContentsOfFile:plistCatPath];

    NSMutableArray *returnData = [[NSMutableArray alloc] init];
    
    for(NSDictionary *tempLocationData in locDataArray){
        GPSLocationData *locationData = [[GPSLocationData alloc] init];
        
        [locationData setTitle:[tempLocationData objectForKey:kTitle]];
        [locationData setLatitude:[tempLocationData objectForKey:kLat]];
        [locationData setLongitude:[tempLocationData objectForKey:kLong]];
        [locationData setRadius:[tempLocationData objectForKey:kRadius]];
        [locationData setImage:[tempLocationData objectForKey:kImage]];
        
        [returnData addObject:locationData];
    }
    
   // NSLog(@"Location data %@", locDataArray);
    return returnData;

}
@end
