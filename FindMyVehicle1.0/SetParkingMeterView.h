//  SetParkingMeterView.h
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 10/2/15.
//  Copyright © 2015 Mark Shepherd. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface SetParkingMeterView : NSObject



@property (nonatomic) NSTimeInterval timerDuration;
@property (nonatomic) bool isTimePicked;
@property (strong, nonatomic) IBOutlet UIAlertView *setMeterView;


@end


