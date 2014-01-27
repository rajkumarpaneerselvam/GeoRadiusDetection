//
//  GPSAppDelegate.h
//  GeoRadiusDetection
//
//  Created by BalaBaskaran on 23/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPSAppDelegate : UIResponder <UIApplicationDelegate> {
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *mode;
@property (nonatomic, retain) NSArray *locationCollection;

@end
