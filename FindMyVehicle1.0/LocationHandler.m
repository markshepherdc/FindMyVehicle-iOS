//
//  LocationHandler.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 4/27/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "LocationHandler.h"

@interface LocationHandler ()


@end



@implementation LocationHandler{
    
    
    
    
}

-(id)init{
    
    self =[super init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.geocoder = [[CLGeocoder alloc] init];

    self.locationManager.delegate = self;
    self.mapView_.delegate =self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.mapView_.delegate=self;
    
    return self;
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.currentLocation = newLocation;
    
    if (self.currentLocation != nil) {
        GMSCameraPosition *cur = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
                                                             longitude:self.currentLocation.coordinate.longitude
                                                                  zoom:17
                                                               bearing:30
                                                          viewingAngle:40];
        
        GMSCameraUpdate *update = [GMSCameraUpdate setCamera:cur];
         [self.mapView_ setMinZoom:5 maxZoom:20];
        [self.mapView_ moveCamera:update];
        
        
    }
    [self.locationManager stopUpdatingLocation];
    
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [self.geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            self.placemark = [placemarks lastObject];
            
            self.approxCarAddress  = [NSString stringWithFormat:@"%@ %@\n%@ %@,%@ \n%@",
                                 self.placemark.subThoroughfare, self.placemark.thoroughfare,
                                 self.placemark.postalCode, self.placemark.locality,
                                 self.placemark.administrativeArea,
                                 self.placemark.country];
            
            //Save Current Date/Time
            NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
            [DateFormatter setDateFormat:@"MM-dd-yy hh:mm a"];
            self.curentDateTime =[DateFormatter stringFromDate:[NSDate date]];
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
}





@end