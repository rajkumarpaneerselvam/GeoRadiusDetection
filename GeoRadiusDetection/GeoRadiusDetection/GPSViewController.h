//
//  GPSViewController.h
//  GeoRadiusDetection
//
//  Created by BalaBaskaran on 23/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITextField *txtLat;

@property (weak, nonatomic) IBOutlet UITextField *txtLon;

@property (weak, nonatomic) IBOutlet UIButton *btnSelector;



@end
