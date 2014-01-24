//
//  GPSLocationData.h
//  GeoRadiusDetection
//
//  Created by Panneerselvam, Rajkumar on 1/24/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSLocationData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSString *image;

@end
