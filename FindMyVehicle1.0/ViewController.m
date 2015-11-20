//
//  ViewController.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 3/4/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#import "ViewController.h"
#import "HistoryTableViewController.h"
#import "StreetViewSubView.h"
#import "LocationHandler.h"
#import "CarLocationData.h"
#import "CoreDataHandler.h"
#import "SetParkingMeterView.h"
//#import "Reachability.h"
#import "NetworkStatusController.h"




//#import <SystemConfiguration/SystemConfiguration.h>



@interface ViewController ()

@property (strong) NSMutableArray *devices;

@end

@implementation ViewController{

    HistoryTableViewController* hTVC;
    StreetViewSubView *sVSV;
    LocationHandler *lH;
    CarLocationData *cLD;
    IadBannerView *aDview;
    SetParkingMeterView *pMeterC;
    NetworkStatusController *netStatusCon;
    
    CLLocation *currentCarLocation;
    float currentCarLocationLat;
    float currentCarLocationLong;
    NSString  *currentCarAddress;
    NSString *curentTime;
    CoreDataHandler *coreDataHand;
    BOOL carParked;
    
    UIImage *navImage;
    UIImage *parkImage;
    UIImage *meterImage;
    UIImage *startMeterImage;
    
    
    
    //Parking meter timer variables
    
    BOOL isTimerRunning;
    BOOL isPaused;
    int hours;
    int minutes;
    int seconds;
    int secondsCount;
    NSTimer *timer;
    NSTimeInterval duration;
    
}

@synthesize parkingTimerLabel;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    


     hTVC = [[HistoryTableViewController alloc]init];
     sVSV = [[StreetViewSubView alloc] init];
     lH = [[LocationHandler alloc]init];
    aDview= [[IadBannerView alloc]init];
    pMeterC= [[SetParkingMeterView alloc]init];
    //lH.mapView_.delegate=self;
    
    //Checks if internet connection is established
    netStatusCon = [[NetworkStatusController alloc]init];
    [netStatusCon reachabilityNotificationSetup];
    
    
    //Sets the title of the Buttons
    [[UIBarButtonItem appearance] setTintColor:[UIColor redColor]];
    
    
    
    [self.getLocationButton  setTitle:@"Map"];
    [self.getLocationButton setImage:[UIImage imageNamed:@"mapicon.png"]];
    
    [self.getStreetViewButton setTitle:@"SV"];
    self.getStreetViewButton.enabled=NO;
    [self.getStreetViewButton setImage:[UIImage imageNamed:@"svicon.png"]];
    
    [self.shareButton setTitle:@"Share"];
    self.shareButton.enabled=NO;
    [self.shareButton setImage:[UIImage imageNamed:@"shareicon.png"]];
    
    [self.historyButton setTitle:@"Past"];
    [self.historyButton setImage:[UIImage imageNamed:@"historyicon.png"]];
    

    
    UIImage *cancelImage = [UIImage imageNamed:@"erase.png"];
    [self.cancelPark setImage:cancelImage forState:UIControlStateNormal];
    self.cancelPark.tintColor = [UIColor redColor];
    
    [self.parkingButton setTitle:@"Park" forState:UIControlStateNormal];
    parkImage = [UIImage imageNamed:@"parklogo.png"];

    navImage = [UIImage imageNamed:@"navicon.png"];
    [self.parkingButton setImage:parkImage forState:UIControlStateNormal];
    self.parkingButton.tintColor=[UIColor redColor];
    
    
    [self.parkingMeterButton setTitle:@"" forState:UIControlStateNormal];
    meterImage = [UIImage imageNamed:@"meter.png"];
    [self.parkingMeterButton setImage:meterImage forState:UIControlStateNormal];
    self.parkingMeterButton.tintColor=[UIColor redColor];
    
    self.parkingTimerLabel.text=@"";
    self.meterPauseButton.hidden=YES;
    
    [self.parkingMeterButton setTitle:@"" forState:UIControlStateNormal];
    startMeterImage = [UIImage imageNamed:@"play.png"];
    [self.meterStartButton setImage:startMeterImage forState:UIControlStateNormal];

    

    [lH.locationManager startUpdatingLocation];
    
    //Adds subviews
   [self addSubViews];
    
    [self.view bringSubviewToFront:self.parkingButton];
    carParked=false;
    
   [self.view addSubview:aDview.banner];
   aDview.banner.frame = self.adview.frame;
    [self.view bringSubviewToFront:aDview.banner];

}

#pragma mark Button Functions
- (IBAction)captureParkingLocation:(UIButton *)sender {
 
    
    if([netStatusCon checkNetworkStatus])
    {
    
    if ([self.parkingButton.currentTitle isEqual:@"Park"]) {
        carParked = true;
        [lH.locationManager startUpdatingLocation];
        
        currentCarLocation=lH.currentLocation;
        currentCarLocationLat=currentCarLocation.coordinate.latitude;
        currentCarLocationLong=currentCarLocation.coordinate.longitude;
        currentCarAddress= lH.approxCarAddress;
        curentTime = lH.curentDateTime;
        
        [self.view bringSubviewToFront:self.meterStartButton];
        [self.view bringSubviewToFront:self.meterPauseButton];
        [self.view bringSubviewToFront:self.parkingTimerLabel];
        [self.view bringSubviewToFront:self.parkingMeterButton];
        [self.view bringSubviewToFront:self.cancelPark];
        

        
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(currentCarLocationLat,currentCarLocationLong);
        marker.icon = [UIImage imageNamed:@"racing.png"];
        marker.title = @"Address ";
        marker.snippet = [NSString stringWithFormat:@"%@ ",currentCarAddress];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = lH.mapView_;

        self.getStreetViewButton.enabled=YES;
        self.shareButton.enabled=YES;
        
        [self.parkingButton setTitle:@"NAV" forState:UIControlStateNormal ];
        [self.parkingButton setImage:navImage forState:UIControlStateNormal];
        self.parkingButton.tintColor=[UIColor blueColor];
        
    } else if ([self.parkingButton.currentTitle isEqual:@"NAV"]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Navigate?" message:@"Would you like to open Google Maps to navigate to car?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Cancel"];
        [alert setTag:2];
        [alert show];
        
        [self.view bringSubviewToFront:self.meterStartButton];
        [self.view bringSubviewToFront:self.meterPauseButton];
        [self.view bringSubviewToFront:self.parkingTimerLabel];
        [self.view bringSubviewToFront:self.parkingMeterButton];
        [self.view bringSubviewToFront:self.cancelPark];
    }
    
    }
    
}

- (IBAction)showMapView:(id)sender{
    if([netStatusCon checkNetworkStatus])
    {
    
    
    [self.view bringSubviewToFront:lH.mapView_];
    [self.view bringSubviewToFront:self.parkingButton];

    if (carParked) {
        [self.view bringSubviewToFront:self.meterStartButton];
        [self.view bringSubviewToFront:self.meterPauseButton];
     [self.view bringSubviewToFront:self.cancelPark];
        [self.view bringSubviewToFront:self.parkingTimerLabel];
        [self.view bringSubviewToFront:self.parkingMeterButton];
    }
    
    
    
}
}

- (IBAction)historyOfParkingSpaces:(id)sender{
    
    if([netStatusCon checkNetworkStatus])
    {
    

   // [pMeterC.setMeterView show];

    [self.view bringSubviewToFront:hTVC.historyTableView];
    NSLog(@"%@", hTVC.parkingHistory);
        
    }
}

- (IBAction)showStreetViewOfVehicle:(id)sender {
    if([netStatusCon checkNetworkStatus])
    {
    [sVSV.panoView moveNearCoordinate:CLLocationCoordinate2DMake(currentCarLocationLat,currentCarLocationLong)];
    [self.view bringSubviewToFront:sVSV.panoView];
    }
}

- (IBAction)shareParkingLocation:(id)sender{
    
    if([netStatusCon checkNetworkStatus])
    {
    
    NSString *sharedInfo = [NSString stringWithFormat:@"%@ ",lH.approxCarAddress];
    NSArray *infoToShare = @[sharedInfo];
    UIActivityViewController *sharedActivityVC = [[UIActivityViewController alloc]initWithActivityItems:infoToShare applicationActivities:nil];
    sharedActivityVC.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard];
    [self presentViewController: sharedActivityVC animated:YES completion:Nil];
        
    }
}

- (IBAction)cancelParkingRequest:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel Park?" message:@"Are you sure you don't want to park here?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Cancel"];
    [alert setTag:1];
    [alert show];
  
}


- (IBAction)activateParkingMeter:(id)sender {
    
    [pMeterC.setMeterView show];
    NSLog(@"%@   Timer Label",parkingTimerLabel.text);
    
  //  while(pMeterC.setMeterView.visible){

 //   }
    
    
    
   
    
}


//Canceling Parking Location
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 1) {    // it's the Error alert
        if (buttonIndex == 0) {     // and they clicked
            [lH.mapView_ clear];
            carParked=false;
            [self.view bringSubviewToFront:lH.mapView_];
            [timer invalidate];
            self.parkingTimerLabel.text=@"00:00:00";
            [self.view bringSubviewToFront:self.parkingButton];
            [self.parkingButton setImage:parkImage forState:UIControlStateNormal];
            [self.parkingButton setTitle:@"Park" forState:UIControlStateNormal ];
            self.parkingButton.tintColor=[UIColor redColor];
            
            self.getStreetViewButton.enabled=NO;
            self.shareButton.enabled=NO;
            
        }
    }
#pragma mark Alertview Actioms
//Navigate to Car
   
    if ([alertView tag] == 2) {    // it's the Error alert
        if (buttonIndex == 0) {     // and they clicked
            [lH.mapView_ clear];
            carParked=false;
            
            [self.view bringSubviewToFront:lH.mapView_];
            [self.view bringSubviewToFront:self.parkingButton];
            [self.parkingButton  setTitle:@"Park" forState:UIControlStateNormal];
            [self.parkingButton setImage:parkImage forState:UIControlStateNormal];
            self.parkingButton.tintColor=[UIColor redColor];
            
            
            [lH.locationManager startUpdatingLocation];
       
            NSString *carDirectionURL =[NSString stringWithFormat:@"http://maps.google.com/maps?t=m&saddr=%f,%f&daddr=%f,%f&dirflg=w",lH.currentLocation.coordinate.latitude, lH.currentLocation.coordinate.longitude, currentCarLocationLat, currentCarLocationLong];
            
             NSString *streetViewImageURL =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/streetview?size=300x300&location=%f,%f&heading=151.78&pitch=-0.76", currentCarLocationLat, currentCarLocationLong];
            
       
            
            cLD = [[CarLocationData alloc]initWithcarAddress:currentCarAddress
                                              carLocationLat:currentCarLocationLat
                                             carLocationLong:currentCarLocationLong
                                               googleMapsUrL:carDirectionURL
                                              streetViewImageURL: streetViewImageURL
                                            parkingDate:curentTime];
                   
            
 
            [hTVC.parkingHistory insertObject:cLD atIndex:0];
            [[hTVC.parkingHistory objectAtIndex:0]carAddress];
            [hTVC.historyTableView reloadData];
            
            [coreDataHand saveParkingDataToStorage:[[hTVC.parkingHistory objectAtIndex:0]carAddress]
                                            MapURL:[[hTVC.parkingHistory objectAtIndex:0]googleMapsURL]
                                              DateParked:[[hTVC.parkingHistory objectAtIndex:0]parkingDate]
                                        SVImageURL:[[hTVC.parkingHistory objectAtIndex:0]streetViewImageURL]
                                            carLat :(float) currentCarLocationLat
                                            carLong :(float) currentCarLocationLong];
            
            
            self.getStreetViewButton.enabled=NO;
            self.shareButton.enabled=NO;
         
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:carDirectionURL]];
        }
    }
    
}

#pragma mark SubRoutines
-(void) addSubViews{
    //MapView------------------------------------------------------------------------------
    lH.mapView_ = [GMSMapView mapWithFrame:self.subMapView.frame camera:lH.camera];
   lH.mapView_.myLocationEnabled = YES;
    lH.mapView_.settings.myLocationButton = YES;
    
    [self.view addSubview:lH.mapView_];
    
    //Street View----------------------------------------------------------------------
    sVSV.panoView =[[GMSPanoramaView alloc] initWithFrame:self.subMapView.frame];
    [self.view insertSubview:sVSV.panoView belowSubview:lH.mapView_];
    
    //TableView-------------------------------------------------------------------------
    hTVC.historyTableView.frame = self.subMapView.frame;
    [self.view insertSubview:hTVC.historyTableView belowSubview:sVSV.panoView];
}


#pragma timerFunctions
- (IBAction)startStopMeter:(id)sender {

    duration=pMeterC.timerDuration;
  
    if(duration > 0)
    {
    seconds = 0;
    hours = (int)(duration/3600.0f);
    minutes = ((int)duration - (hours * 3600))/60;
    
    secondsCount = ((hours * 3600) + (minutes * 60));
    
   
         parkingTimerLabel.text=[NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];

    
    if (isTimerRunning == YES) {
         //   parkingTimerLabel.alpha = 0;
        
        //       [startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        //       [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        //      pauseButton.enabled = NO;
    
        [timer invalidate];
        timer = nil;
        
    } else {
          //   parkingTimerLabel.alpha = 1;
        
        //    [startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        //  pauseButton.enabled = YES;
        
        
        
        if (timer == nil) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(updateTimer)
                                                   userInfo:nil
                                                    repeats:YES];
   
        }
        
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
   
         parkingTimerLabel.text=[NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];

    
    
    
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
        
        
        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
        localNotification.alertBody = @"Meter Expired";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    }
    
}
- (IBAction)pauseMeter:(id)sender {

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
        
      /*
        [self performSelectorOnMainThread:@selector (updateTimer)
                               withObject:vControler.parkingTimerLabel
                            waitUntilDone:NO];*/
        
        
        //        [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
    isPaused = !isPaused;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

   coreDataHand = [[CoreDataHandler alloc]initWithcarData:hTVC];
[coreDataHand fetchExistingParkingData];
    
    hTVC.VcContext = [coreDataHand managedObjectContext]; ;
    
 
}

@end
