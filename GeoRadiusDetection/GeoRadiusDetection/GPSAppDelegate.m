//
//  GPSAppDelegate.m
//  GeoRadiusDetection
//
//  Created by BalaBaskaran on 23/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import "GPSAppDelegate.h"
#import "GeoRadiusDataModel.h"


@implementation GPSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




////Explicitly write Core Data accessors
//- (NSManagedObjectContext *) managedObjectContext {
//    if (managedObjectContext != nil) {
//        return managedObjectContext;
//    }
//    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//    if (coordinator != nil) {
//        managedObjectContext = [[NSManagedObjectContext alloc] init];
//        [managedObjectContext setPersistentStoreCoordinator: coordinator];
//    }
//    
//    return managedObjectContext;
//}
//
//- (NSManagedObjectModel *)managedObjectModel {
//    if (managedObjectModel != nil) {
//        return managedObjectModel;
//    }
//    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
//    
//    return managedObjectModel;
//}
//
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
//    if (persistentStoreCoordinator != nil) {
//        return persistentStoreCoordinator;
//    }
//    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
//                                               stringByAppendingPathComponent: @"GeoRadiusDetection.sqlite"]];
//    NSError *error = nil;
//    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
//                                  initWithManagedObjectModel:[self managedObjectModel]];
//    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
//                                                 configuration:nil URL:storeUrl options:nil error:&error]) {
//        /*Error for store creation should be handled in here*/
//    }
//    
//    return persistentStoreCoordinator;
//}
//
//- (NSString *)applicationDocumentsDirectory {
//    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//}
//
//
//#pragma mark - Insert Content
//
//- (void)insertContentIntoCoreData {
//    NSManagedObjectContext *context = [self managedObjectContext];
//    GeoRadiusDataModel *dataObj = [NSEntityDescription   insertNewObjectForEntityForName:@"GeoRadiusDataModel" inManagedObjectContext:context];
//    
//    dataObj.latitude = @"22.596996";
//    dataObj.longtitude = @"49.02883";
//    dataObj.image = @"dallas.png";
//    dataObj.title = @"Test Chase";
//    dataObj.radius = @"2.0";
//
//    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"========Error in saving data in data model=============");
//    }
//    
//    
// }

@end
