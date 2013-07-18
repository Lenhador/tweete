//
//  SingletonGPS.m
//  SingletonGPS
//
//  Created by Aleksandr Belov on 5/24/13.
//  Copyright (c) 2013 Lenhador. All rights reserved.
//

#import "TWSManager.h"
#import "TWSValidator.h"

@interface ConnectionManager ()
- (void) getAddressWithLatlng : (NSString *)latlng;

@end

@implementation ConnectionManager

static ConnectionManager *gpsObject = nil;

#pragma mark - Singlton method

+ (ConnectionManager *) sharedInstanse {
        dispatch_once_t oncePredicate = 0;
    dispatch_once(&oncePredicate, ^{
        gpsObject = [[ConnectionManager alloc] init];
        gpsObject.locationManager = [[CLLocationManager alloc] init];
    });
    
    return gpsObject;
}
#pragma mark - public methods 

- (void) startUpdateLocation {
    
    [_locationManager setDelegate:self];
    [_locationManager startUpdatingLocation];
}

- (void) stopUpdateLocation {
    
    [_locationManager stopUpdatingLocation];
    [_locationManager setDelegate:nil];
}
- (void) getAddressWithLatlng:(NSString *)latlng {
    NSUInteger radius = 500;
    NSString *types = @"bank";
    //NSString *name = @"harbor";
    	
    NSString *sensor = @"true";

    NSURL *urlFindPlaces = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?language=ru&location=%@&radius=%d&types=%@&sensor=%@&key=%@", latlng, radius,types, sensor, API_KEY]];
    
    
    NSMutableData *jsonResponse = [NSMutableData dataWithContentsOfURL:urlFindPlaces];
    NSError *error = nil;
    NSDictionary *parseResponse = [NSJSONSerialization JSONObjectWithData:jsonResponse options:NSJSONReadingMutableLeaves error:&error];
    if(error) {
        NSLog(@"Error : %@", [error userInfo]);
    }
    NSArray *array = [TWSValidator getArrayWithObject:[parseResponse objectForKey:@"results"]];
    if(array.count > 0)
    _activeAddresses = [TWSValidator getValidBankWithArray:array];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocationCoordinate2D currentLoc = [[locations lastObject] coordinate];
    
    NSString *stringLatitudeLongitude = [NSString stringWithFormat:@"%f,%f", currentLoc.latitude, currentLoc.longitude];
    
    [self getAddressWithLatlng:stringLatitudeLongitude];
    
    [self stopUpdateLocation];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Call method - locationManager:didFailWithError:(NSError *)error = %@", error);
}
@end
