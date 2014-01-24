//
//  GPSCoredataManager.m
//  GeoRadiusDetection
//
//  Created by Kumaran on 24/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import "GPSCoredataManager.h"
#import "GeoRadiusDataModel.h"
#import "GPSUtilitiesPlist.h"

@implementation GPSCoredataManager

@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;


//Explicitly write Core Data accessors
- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"GeoRadiusDetection.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark - Insert Content

- (void)insertContentIntoCoreData {
    
//    
//    GPSUtilitiesPlist *utility = [[GPSUtilitiesPlist alloc] init];
//    NSMutableArray *dataArr = [utility getLocationData];
//    
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
}



#pragma Coredata content

- (void) readContentFromCoreData {
    
    NSManagedObjectContext *context = [self managedObjectContext];

    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"GeoRadiusDataModel"
                                           inManagedObjectContext:context];
    [req setEntity:des];

    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:req error:&error];

    for (GeoRadiusDataModel *obj in fetchedObjects) {

        NSLog(@"Latitude: %@", obj.latitude);
        NSLog(@"Longtitude: %@", obj.longtitude);
        NSLog(@"Radius: %@", obj.radius);
        NSLog(@"Image: %@", obj.image);
        NSLog(@"Title: %@", obj.title);
    }
    
}

@end
