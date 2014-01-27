//
//  GPSCoredataManager.h
//  GeoRadiusDetection
//
//  Created by Kumaran on 24/01/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSCoredataManager : NSObject {
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSManagedObjectContext *) managedObjectContext;
- (void)insertContentIntoCoreData;
- (NSMutableArray *) readContentFromCoreData;
@end
