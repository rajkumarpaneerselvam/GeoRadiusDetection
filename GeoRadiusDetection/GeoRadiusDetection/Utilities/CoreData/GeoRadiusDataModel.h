//
//  GeoRadiusDataModel.h
//  GeoRadiusDetection
//
//  Created by Kumaran on 24/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GeoRadiusDataModel : NSManagedObject

//@property (nonatomic, retain) NSString * title;
//@property (nonatomic, retain) NSString * radius;
//@property (nonatomic, retain) NSString * latitude;
//@property (nonatomic, retain) NSString * longtitude;
//@property (nonatomic, retain) NSString * image;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSString *image;


@end
