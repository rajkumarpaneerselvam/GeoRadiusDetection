//
//  GPSSqliteHelper.h
//  GeoRadiusDetection
//
//  Created by Panneerselvam, Rajkumar on 1/24/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPSLocationData.h"
#import <sqlite3.h>
#import <CoreLocation/CoreLocation.h>


@interface GPSSqliteHelper : NSObject

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *locationCollectionDB;

-(void)initialize;
-(void)prepareData:(NSArray *)locationCollection;
-(void)fetchLocation;
-(NSString *)deriveZoneImage:(CLLocation *)locationInfo;
@end
