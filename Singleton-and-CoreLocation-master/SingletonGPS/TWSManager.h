//
//  SingletonGPS.h
//  SingletonGPS
//
//  Created by Aleksandr Belov on 5/24/13.
//  Copyright (c) 2013 Lenhador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define API_KEY @"AIzaSyB4vVD0jQRylP46g8eDO5hQhwekxbV53gc"

@interface ConnectionManager : NSObject <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property (strong, nonatomic) NSDictionary *activeAddresses;

+ (ConnectionManager *) sharedInstanse;

- (void) startUpdateLocation;
- (void) stopUpdateLocation;

@end
