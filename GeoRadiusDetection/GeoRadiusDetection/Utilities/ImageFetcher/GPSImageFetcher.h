//
//  GPSImageFetcher.h
//  GeoRadiusDetection
//
//  Created by Rajkumar P on 1/27/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GPSImageFetcher : NSObject{
    
}

+ (UIImage *)imageForLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;
+ (UIImage *)imageForLocation:(CLLocation *)location;

@end
