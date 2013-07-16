//
//  GMapDataModel.m
//  AskedonTable
//
//  Created by Администратор on 4/25/13.
//  Copyright (c) 2013 Lenhador. All rights reserved.
//

#import "GMapDataModel.h"

@interface GMapDataModel ()



@end
@implementation GMapDataModel

- (void) startUpdateLocation {
    [_locationManager startUpdatingLocation];
}

- (void) stopUpdateLocation {
    [_locationManager stopUpdatingLocation];
}

- (id) init {
    self = [super init];
    
    if(self) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%@", locations);
}

- (void) getAddressWithLatlng:(NSString *)latlng target:(NSString *)target {

    NSMutableData *jsonResponse = [NSMutableData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?language=en&latlng=%@&sensor=true", latlng]]];
    
    NSDictionary *parseResponse = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:nil];
    
    //Вытаскиваем нужный нам адрес (в ответе с сервера сверху вниз указаны адреса, по наибольшей вероятности совпадения)
    NSString *result = [[[parseResponse valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"];
    
}

@end
