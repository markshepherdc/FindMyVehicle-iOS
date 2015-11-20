//
//  HistoryTableViewController.h
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 4/26/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "ViewController.h"
@class CoreDataHandler;
@class ViewController;
@class CarLocationData;





@interface HistoryTableViewController : UITableView<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *historyTableView;
@property (strong, nonatomic) NSMutableArray *parkingHistory;
@property (strong, nonatomic) NSManagedObjectContext *VcContext;

//DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

//Delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section ;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat) tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
    
@end



