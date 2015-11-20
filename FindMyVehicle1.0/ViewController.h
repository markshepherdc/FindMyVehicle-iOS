//
//  ViewController.h
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 3/4/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#include "IadBannerView.h"
#import <iAd/iAd.h>
@class SetParkingMeterView;


@interface ViewController : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate, ADBannerViewDelegate>



@property (strong, nonatomic) IBOutlet UIBarButtonItem *getLocationButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *getStreetViewButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *historyButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelPark;
@property (strong, nonatomic) NSManagedObject *pHistory;
@property (strong, nonatomic) IBOutlet UIButton *parkingButton;
@property (strong, nonatomic) IBOutlet UIButton *parkingMeterButton;

@property (nonatomic, assign) BOOL buttonClicked;
@property (strong, nonatomic) IBOutlet UIView *subMapView;
@property (strong, nonatomic) IBOutlet ADBannerView *adview;

- (IBAction)showStreetViewOfVehicle:(id)sender ;
- (IBAction)captureParkingLocation:(id)sender;
- (IBAction)shareParkingLocation:(id)sender;
- (IBAction)historyOfParkingSpaces:(id)sender;
- (IBAction)cancelParkingRequest:(id)sender;
- (IBAction)showMapView:(id)sender;


//Meterfunctions
- (IBAction)activateParkingMeter:(id)sender;
- (IBAction)startStopMeter:(id)sender;
- (IBAction)pauseMeter:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *meterStartButton;
@property (strong, nonatomic) IBOutlet UIButton *meterPauseButton;




@property (strong, nonatomic) IBOutlet UILabel *parkingTimerLabel;


@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

@end
