//
//  NetworkStatusController.h
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 9/27/15.
//  Copyright © 2015 Mark Shepherd. All rights reserved.
//


//#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"


@interface NetworkStatusController : NSObject


-(void)reachabilityNotificationSetup;
-(BOOL) checkNetworkStatus;

@end



