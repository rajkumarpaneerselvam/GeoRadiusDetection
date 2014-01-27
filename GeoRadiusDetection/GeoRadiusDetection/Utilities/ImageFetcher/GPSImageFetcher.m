//
//  GPSImageFetcher.m
//  GeoRadiusDetection
//
//  Created by Rajkumar P on 1/27/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import "GPSImageFetcher.h"
#import "GPSAppDelegate.h"
#import "GPSLocationData.h"
#import "GPSSqliteHelper.h"

@implementation GPSImageFetcher

+ (UIImage *)imageForLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    return [self imageForLocation:[[CLLocation alloc] initWithLatitude:latitude longitude:longitude]];
}

+ (UIImage *)imageForLocation:(CLLocation *)location{
    NSString *imagePath;
    if ([[(GPSAppDelegate *)[UIApplication sharedApplication].delegate mode] isEqualToString:@"plist"]) {
        imagePath = [self imagePathForLocationFromDataCollection:location];
    }else if ([[(GPSAppDelegate *)[UIApplication sharedApplication].delegate mode] isEqualToString:@"sqlite"]){
        imagePath = [self imagePathForLocationFromSqlite:location];
    }
    return [UIImage imageNamed:imagePath];
}

+(NSString *)imagePathForLocationFromDataCollection:(CLLocation *)location{
    
    NSArray *locationCollection = [(GPSAppDelegate *)[UIApplication sharedApplication].delegate locationCollection];
    
    NSString *imagePath = @"default";
    for(GPSLocationData *locationInfo in locationCollection){
        CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:[locationInfo.latitude doubleValue] longitude:[locationInfo.longitude doubleValue]];
        double distance = [location distanceFromLocation:tempLocation] / 1609.34;// Converting to miles
        if(distance <= [locationInfo.radius doubleValue]){
            imagePath = locationInfo.image;
            return imagePath;
        }
    }
    return imagePath;
}

+(NSString *)imagePathForLocationFromSqlite:(CLLocation *)location{
    
    GPSSqliteHelper *sqlHelper = [[GPSSqliteHelper alloc] init];
    return [sqlHelper deriveZoneImage:location];
}

@end
