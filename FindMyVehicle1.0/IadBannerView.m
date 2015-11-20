//
//  IadBannerView.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 7/5/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IadBannerView.h"
@class ViewController;

@interface IadBannerView ()




@end



@implementation IadBannerView{
    
    ViewController *mainView;

    
}

-(id)init{
    
    self.banner = [[ADBannerView alloc]init] ;
    self.banner.delegate=self;
    
    
    return self;
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self._bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (self.banner.superview == nil)
        {
            [mainView.view addSubview:self.banner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
      //  banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        self._bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
    
    if (self._bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
     //   banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
      
        [UIView commitAnimations];
        
        self._bannerIsVisible = NO;
    }
}


@end

