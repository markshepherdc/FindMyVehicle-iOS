//
//  CoreDataHandler.h
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 6/8/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#ifndef FindMyVehicle1_0_CoreDataHandler_h
#define FindMyVehicle1_0_CoreDataHandler_h


#endif

#import <Foundation/Foundation.h>
#import "HistoryTableViewController.h"
@class HistoryTableViewController;




@interface CoreDataHandler : NSObject



- (id)initWithcarData :(HistoryTableViewController *) pD;
-(void)fetchExistingParkingData;
- (NSManagedObjectContext *)managedObjectContext ;

-(void)saveParkingDataToStorage: (NSString *) carAddress
                        MapURL : (NSString *) googleMapsURL
                    DateParked :(NSString *) parkingDate
                    SVImageURL :(NSString *) streetViewImageURL
                        carLat :(float) carLocationLat
                       carLong :(float) carLocationLong;

@end
