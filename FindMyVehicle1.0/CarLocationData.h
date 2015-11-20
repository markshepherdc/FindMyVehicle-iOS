//
//  CarLocationData.h
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 5/11/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CarLocationData : NSObject

@property (strong, nonatomic) NSString *carAddress;
@property (strong, nonatomic) CLLocation *carLocation;
@property (strong, nonatomic) NSString *googleMapsURL;
@property (strong, nonatomic) NSString *streetViewImageURL;
@property (strong, nonatomic) NSString *parkingDate;
@property (nonatomic) double carLocationLat;
@property (nonatomic) double carLocationLong;



- (id)initWithcarAddress :(NSString *) cA
              carLocationLat:(float)cLlat
              carLocationLong:(float)cLlong
            googleMapsUrL:(NSString*) gmURL
       streetViewImageURL:(NSString*) sviURL
              parkingDate:(NSString*) pDate;


@end
