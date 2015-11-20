//
//  CarLocationData.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 5/1/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//



#import "CarLocationData.h"

@interface CarLocationData ()

//@property (strong, nonatomic) IBOutlet NSString *carAddress;

@end

//@synthesize   *carAddress;

@implementation CarLocationData{

}
- (id)initWithcarAddress :(NSString *) cA
           carLocationLat:(float)cLlat
          carLocationLong:(float)cLlong
            googleMapsUrL:(NSString*) gmURL
       streetViewImageURL:(NSString*) sviURL
              parkingDate:(NSString*) pDate;
{
   
    self.carAddress=cA;
      self.carLocationLat=cLlat;
    self.carLocationLong=cLlong;
     self.googleMapsURL=gmURL;
      self.streetViewImageURL=sviURL;
      self.parkingDate=pDate;
    return self;
    
}


    





@end