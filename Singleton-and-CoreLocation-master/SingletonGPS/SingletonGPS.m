//
//  SingletonGPS.m
//  SingletonGPS
//
//  Created by Aleksandr Belov on 5/24/13.
//  Copyright (c) 2013 Lenhador. All rights reserved.
//

#import "SingletonGPS.h"
#import "TWSValidator.h"

@implementation SingletonGPS

static SingletonGPS *gpsObject = nil;

+ (SingletonGPS *) sharedInstanse {
    
    dispatch_once_t oncePredicate = 0;
    dispatch_once(&oncePredicate, ^{
        gpsObject = [[SingletonGPS alloc] init];
        gpsObject.locationManager = [[CLLocationManager alloc] init];
        [gpsObject.locationManager setDelegate:gpsObject];
        [gpsObject.locationManager startUpdatingLocation];
    });
    
    return gpsObject;
}

- (id) copy
{
    return self;
}


- (void) getAddressWithLatlng:(NSString *)latlng target:(NSString *)target {
    NSUInteger radius = 5000;
    NSString *types = @"bank";
    //NSString *name = @"harbor";
    NSString *sensor = @"true";

    NSURL *urlFindPlaces = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?language=ru&location=%@&radius=%d&types=%@&sensor=%@&key=%@", self.location, radius,types, sensor, API_KEY]];

    NSMutableData *jsonResponse = [NSMutableData dataWithContentsOfURL:urlFindPlaces];
    NSError *error = nil;
    NSDictionary *parseResponse = [NSJSONSerialization JSONObjectWithData:jsonResponse options:NSJSONReadingMutableLeaves error:&error];
    if(error) {
        NSLog(@"Error : %@", [error userInfo]);
    }
    NSArray *array = [TWSValidator getArrayWithObject:[parseResponse objectForKey:@"results"]];
    
    _activeAddresses = [TWSValidator getValidBankWithArray:array];
    
        

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocationCoordinate2D currentLoc = [[locations lastObject] coordinate];
    [gpsObject setLocation:[NSString stringWithFormat:@"%f,%f", currentLoc.latitude, currentLoc.longitude]];
    [self getAddressWithLatlng:@"dsad" target:@"dsadsa"];
    [_locationManager stopUpdatingLocation];

}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Call method - locationManager:didFailWithError:(NSError *)error = %@", error);
}
@end
