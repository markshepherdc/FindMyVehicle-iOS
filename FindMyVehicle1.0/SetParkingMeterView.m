//
//  SetParkingMeterView.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 10/2/15.
//  Copyright © 2015 Mark Shepherd. All rights reserved.
//

#import "SetParkingMeterView.h"
#import "ParkingMeterTimerController.h"

@interface SetParkingMeterView ()



@end



@implementation SetParkingMeterView{
    
    
    UIDatePicker *datePicker;
    ParkingMeterTimerController *pMTC;
    
}

@synthesize setMeterView, timerDuration, isTimePicked;

-(id)init{
    
    
    datePicker = [[UIDatePicker alloc] init];
    datePicker.frame=CGRectMake(20, 45.0, 240.0, 150.0);
    datePicker.backgroundColor = [UIColor clearColor];
    [datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
    datePicker.minuteInterval=5;
    setMeterView = [[UIAlertView alloc] initWithTitle:@"Meter" message:@"Please select time" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Set Timer", nil];
    [setMeterView  setValue:datePicker forKey:@"accessoryView"];
    isTimePicked=false;
    
   
    
    return self;
}

-(void)showParkingMeterSetter{
    
    [setMeterView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        
        isTimePicked=true;
        NSLog(@"%f", datePicker.countDownDuration);
        timerDuration=datePicker.countDownDuration;
    //   pMTC=[[ParkingMeterTimerController alloc]initWithDuration:timerDuration];
    //    [pMTC startStopMeter];

    }
    
}

@end


