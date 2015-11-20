//
//  ParkingMeterController.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 9/20/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//


#import "ParkingMeterTimerController.h"
#import "ViewController.h"



@interface ParkingMeterTimerController ()

@end

@implementation ParkingMeterTimerController{
    
    BOOL isTimerRunning;
    BOOL isPaused;
    int hours;
    int minutes;
    int seconds;
    int secondsCount;
    NSTimer *timer;
    NSTimeInterval duration;
    ViewController *vControler;
}


- (id)initWithDuration :(NSTimeInterval) dur

{
    
    duration=dur;
    return self;

    isTimerRunning = NO;
    isPaused = NO;
 //   pauseButton.enabled = NO;
    
    vControler = [[ViewController alloc]init];

}

- (void)startStopMeter {
    

    seconds = 0;
    hours = (int)(duration/3600.0f);
    minutes = ((int)duration - (hours * 3600))/60;
    
    secondsCount = ((hours * 3600) + (minutes * 60));
    
    //Accessing UI Thread
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
    {
    vControler.parkingTimerLabel.text=[NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
    }];
    
    if (isTimerRunning == YES) {
     
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
        vControler.parkingTimerLabel.alpha = 0;
             
         }];
        
        
        
 //       [startStopButton setTitle:@"Start" forState:UIControlStateNormal];
 //       [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
  //      pauseButton.enabled = NO;

    
        
        [timer invalidate];
        timer = nil;
        
    } else {
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             vControler.parkingTimerLabel.alpha = 1;
             
         }];
    //    [startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
      //  pauseButton.enabled = YES;
        
        
        
        if (timer == nil) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(updateTimer)
                                                   userInfo:nil
                                                    repeats:YES];
            
            
            [self performSelectorOnMainThread:@selector (updateTimer)
                                   withObject:vControler.parkingTimerLabel
                                waitUntilDone:NO];
        }
        
    }
    
    isTimerRunning = !isTimerRunning;
}

- (void) updateTimer {
    
    secondsCount--;
    hours = secondsCount/3600;
    minutes = (secondsCount % 3600)/60;
    seconds = (secondsCount % 3600) % 60;
    
   // seconds = secondsCount - (minutes * 60);
    
    // NSLog(@"%i", minutes);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         vControler.parkingTimerLabel.text=[NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
     }];;
    
    
    
    // Send Reminder for meter at 5 mins
    
    if (secondsCount==300) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
        localNotification.alertBody = @"Meter Expires in 5 mins";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
    }
    
    if (secondsCount <= 0) {
        
        [timer invalidate];
        timer = nil;
  
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             vControler.parkingTimerLabel.alpha = 0;
         }];
        
   //     [startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    //    pauseButton.enabled = NO;
    }
    
}

- (void)pauseMeter {
    
    if (isPaused == NO) {
        [timer invalidate];
        timer = nil;
        
 //       [pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
        
    } else {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(updateTimer)
                                               userInfo:nil
                                                repeats:YES];
        
        
        [self performSelectorOnMainThread:@selector (updateTimer)
                               withObject:vControler.parkingTimerLabel
                            waitUntilDone:NO];

        
//        [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
    isPaused = !isPaused;
    
}


-(void)updateTimerLabel{
    
    
}
    
@end

