//
//  GPSSqliteHelper.m
//  GeoRadiusDetection
//
//  Created by Panneerselvam, Rajkumar on 1/24/14.
//  Copyright (c) 2014 BalaBaskaran. All rights reserved.
//

#import "GPSSqliteHelper.h"
#define DEG2RAD(degrees) (degrees * 0.01745327) // degrees * pi over 180

@implementation GPSSqliteHelper

@synthesize databasePath = _databasePath;
@synthesize locationCollectionDB = _locationCollectionDB;

-(void)initialize{
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"locationCollection.db"]];
    
    NSLog(@"Db path %@",_databasePath);
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_locationCollectionDB) == SQLITE_OK)
        {
            sqlite3_create_function(_locationCollectionDB, "distance", 4, SQLITE_UTF8, NULL, &distanceFunc, NULL, NULL);
            
            
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS Locations (ID INTEGER PRIMARY KEY AUTOINCREMENT, Title TEXT, Latitude REAL, Longitude REAL, Radius INTEGER, Image TEXT)";
            
            if (sqlite3_exec(_locationCollectionDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            sqlite3_close(_locationCollectionDB);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
    
}

- (void)prepareData:(NSArray *)locationCollection{
    
    for(GPSLocationData *locationData in locationCollection){
        [self insertLocationIntoDB:locationData];
    }
}

# pragma mark public methods

- (void)insertLocationIntoDB:(GPSLocationData *)locationData{
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_locationCollectionDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Locations (Title, Latitude, Longitude , Radius, Image) VALUES ('%@',%f,%f,%d,'%@')",locationData.title,[locationData.latitude doubleValue],[locationData.longitude doubleValue],[locationData.radius intValue],locationData.image];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_locationCollectionDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Location added");
        } else {
            NSLog(@"Failed to add location");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_locationCollectionDB);
    }
    
}

//SELECT * FROM Locations WHERE abs(Latitude - 51.503357) < 0.3 AND abs(Longitude - -0.1199) < 0.3 ORDER BY distance(Latitude, Longitude, 51.503357, -0.1199)

-(NSString *)deriveZoneImage:(CLLocation *)locationInfo{
    
    GPSLocationData *nearByLocation;
    NSString *image = @"default";
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_locationCollectionDB) == SQLITE_OK)
    {
        sqlite3_create_function(_locationCollectionDB, "distance", 4, SQLITE_UTF8, NULL, &distanceFunc, NULL, NULL);
        
//        NSString *querySQL = [NSString stringWithFormat:
//                              @"SELECT * FROM Locations WHERE abs(Latitude - %f) < 0.3 AND abs(Longitude - %f) < 0.3 ORDER BY distance(Latitude, Longitude, %f, %f)",locationInfo.coordinate.latitude,locationInfo.coordinate.longitude,locationInfo.coordinate.latitude,locationInfo.coordinate.longitude];
//        

        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT * FROM Locations ORDER BY distance(Latitude, Longitude, %f, %f)",locationInfo.coordinate.latitude,locationInfo.coordinate.longitude];
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_locationCollectionDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                nearByLocation = [[GPSLocationData alloc] init];
                
                nearByLocation.title = [[NSString alloc]
                                   initWithUTF8String:
                                   (const char *) sqlite3_column_text(
                                                                      statement, 1)];
                
                nearByLocation.latitude = [[NSNumber alloc]
                                 initWithDouble: sqlite3_column_double(statement, 2)];
                
                nearByLocation.longitude = [[NSNumber alloc]
                                 initWithDouble: sqlite3_column_double(statement, 3)];
                
                nearByLocation.radius = [[NSNumber alloc]
                                    initWithInt: sqlite3_column_int(statement, 4)];
                
                nearByLocation.image = [[NSString alloc]
                                   initWithUTF8String:
                                   (const char *) sqlite3_column_text(
                                                                      statement, 5)];
                
                NSLog(@"(%@,%@,%@,%@,%@)",nearByLocation.title,nearByLocation.latitude,nearByLocation.longitude,nearByLocation.radius,nearByLocation.image);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_locationCollectionDB);
    }
    
    CLLocation *nearLocationCoordinated = [[CLLocation alloc] initWithLatitude:[nearByLocation.latitude doubleValue] longitude:[nearByLocation.longitude doubleValue]];
    
    CLLocationDistance distance = [nearLocationCoordinated distanceFromLocation:locationInfo];
    
    distance = distance / 1609.34;
    
    NSLog(@"Distance = %f miles",distance);
    
    if (distance < [nearByLocation.radius doubleValue]) {
        NSLog(@"Inside radius");
        image = nearByLocation.image;
    }else{
        NSLog(@"Outside radius");
    }
    
    return image;
}

#pragma Function injected in to Sqlite

static void distanceFunc(sqlite3_context *context, int argc, sqlite3_value **argv)
{
    // check that we have four arguments (lat1, lon1, lat2, lon2)
    assert(argc == 4);
    // check that all four arguments are non-null
    if (sqlite3_value_type(argv[0]) == SQLITE_NULL || sqlite3_value_type(argv[1]) == SQLITE_NULL || sqlite3_value_type(argv[2]) == SQLITE_NULL || sqlite3_value_type(argv[3]) == SQLITE_NULL) {
        sqlite3_result_null(context);
        return;
    }
    // get the four argument values
    double lat1 = sqlite3_value_double(argv[0]);
    double lon1 = sqlite3_value_double(argv[1]);
    double lat2 = sqlite3_value_double(argv[2]);
    double lon2 = sqlite3_value_double(argv[3]);
    // convert lat1 and lat2 into radians now, to avoid doing it twice below
    double lat1rad = DEG2RAD(lat1);
    double lat2rad = DEG2RAD(lat2);
    // apply the spherical law of cosines to our latitudes and longitudes, and set the result appropriately
    // 6378.1 is the approximate radius of the earth in kilometres
    sqlite3_result_double(context, acos(sin(lat1rad) * sin(lat2rad) + cos(lat1rad) * cos(lat2rad) * cos(DEG2RAD(lon2) - DEG2RAD(lon1))) * 6378.1);
}

@end
