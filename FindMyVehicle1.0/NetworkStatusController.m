//
//  NetworkStatusController.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 9/27/15.
//  Copyright © 2015 Mark Shepherd. All rights reserved.
//

#import "NetworkStatusController.h"

@interface NetworkStatusController ()

@end

@implementation NetworkStatusController {
    
}

-(id)init{
    
    
    return self;
    
}




-(BOOL) checkNetworkStatus
{

    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        return true  ;  }
    else {
        return false;
    }
    
}

-(void)reachabilityNotificationSetup{
    
    Reachability *reachabilityInfo;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkNetworkStatus)
                                                 name:kReachabilityChangedNotification
                                               object:reachabilityInfo];
    
    
}



@end


