//
//  GMapDataModel.h
//  AskedonTable
//
//  Created by Администратор on 4/25/13.
//  Copyright (c) 2013 Lenhador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GMapDataModel : NSObject <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;

- (void) startUpdateLocation;
- (void) stopUpdateLocation;

- (void) getAddressWithLatlng : (NSString *)latlng target : (NSString *)target;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
@end
