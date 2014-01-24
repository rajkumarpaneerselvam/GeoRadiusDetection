//
//  GPSUtilitiesPlist.m
//  GeoRadiusDetection
//
//  Created by Latchumanan, Balabaskaran on 1/24/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import "GPSUtilitiesPlist.h"

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

   // NSLog(@"Location data %@", locDataArray);
    return locDataArray;

}
@end
