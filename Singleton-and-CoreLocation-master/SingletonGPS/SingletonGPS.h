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

@interface SingletonGPS : NSObject <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property NSString *location;
@property (strong, nonatomic) NSDictionary *activeAddresses;
+ (SingletonGPS *) sharedInstanse;
- (void) getAddressWithLatlng : (NSString *)latlng target : (NSString *)target;

@end
