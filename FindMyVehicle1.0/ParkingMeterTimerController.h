//
//  ParkingMeterController.h
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 9/20/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#ifndef FindMyVehicle1_0_ParkingMeterController_h
#define FindMyVehicle1_0_ParkingMeterController_h


#endif

#import <Foundation/Foundation.h>

@interface ParkingMeterTimerController : UIViewController


//@property (nonatomic)  NSTimeInterval *duration;


//Timer Count in seconds
-(id)initWithDuration :(NSTimeInterval) dur;

//Label to reflect time left on parking meter
//@property (strong, nonatomic) IBOutlet UILabel *parkingTimerLabel;

//Start Parking Meter
- (void)startStopMeter;

//Add time to parking meter
- (void)pauseMeter;


@end
