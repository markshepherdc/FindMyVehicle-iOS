//
//  IadBannerView.h
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 7/5/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <iAd/iAd.h>






@interface IadBannerView : UIViewController<ADBannerViewDelegate>

@property (strong, nonatomic) ADBannerView *banner;
@property (nonatomic) BOOL _bannerIsVisible;




@end