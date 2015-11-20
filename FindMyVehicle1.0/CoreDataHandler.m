//
//  CoreDataHandler.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 6/8/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#import "CoreDataHandler.h"
//@class HistoryTableViewController;


@interface CoreDataHandler ()

//@property (strong, nonatomic) IBOutlet NSString *carAddress;

@end

@implementation CoreDataHandler{
    
 HistoryTableViewController *parkingData;
}

- (id)initWithcarData :(HistoryTableViewController *) pD
{
    parkingData=pD;
    return self;
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)fetchExistingParkingData{

    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"LocationInfo"];
    
    parkingData.parkingHistory = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [parkingData.historyTableView reloadData];
}

-(void)saveParkingDataToStorage: (NSString *) carAddress
                              MapURL : (NSString *) googleMapsURL
                              DateParked :(NSString *) parkingDate
                              SVImageURL :(NSString *) streetViewImageURL
                              carLat :(float) carLocationLat
                             carLong :(float) carLocationLong
{
    //Save Table
    NSManagedObjectContext *context = [self managedObjectContext];
    // Create a new managed object
    
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"LocationInfo" inManagedObjectContext:context];
    
    [newDevice setValue:carAddress forKey:@"carAddress"];
    [newDevice setValue:googleMapsURL forKey:@"googleMapsURL"];
    [newDevice setValue:parkingDate forKey:@"parkingDate"];
    [newDevice setValue:streetViewImageURL forKey:@"streetViewImageURL"];
    [newDevice setValue:[NSNumber numberWithFloat:carLocationLat] forKey:@"carLocationLat"];
    [newDevice setValue:[NSNumber numberWithFloat:carLocationLat] forKey:@"carLocationLong"];
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}
@end
