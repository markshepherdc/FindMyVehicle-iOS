//
//  HistoryTableViewController.m
//  FindMyVehicle1.0
//
//  Created by Mark Shepherd on 4/26/15.
//  Copyright (c) 2015 Mark Shepherd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryTableViewController.h"

@interface HistoryTableViewController ()




@end



@implementation HistoryTableViewController{
    
   
    
    
}

-(id)init{
    
    self.parkingHistory= [[NSMutableArray alloc]init];
    self.historyTableView = [[UITableView alloc] init];
    self.historyTableView.delegate=self;
    self.historyTableView.dataSource=self;
   
    
    
    return self;
}



#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Navigate Here?" message:@"Are you want to open Google Maps to navigate to this previous location?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Cancel"];
    [alert setTag:3];
    [alert show];

    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


#pragma mark - Data Source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *tableName;
    
    tableName =@"Parking History";
    
    return tableName;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [self.parkingHistory count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;    }
    
    // Set the data for this cell:
    
    NSManagedObject *storedData = [self.parkingHistory objectAtIndex:indexPath.row];
    [cell.textLabel setText:[storedData valueForKey:@"parkingDate"] ];
    

    cell.detailTextLabel.numberOfLines=4;
    [cell.detailTextLabel setText:[storedData valueForKey:@"carAddress"] ];

    //Cell Image

    
    UIImage *locationImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[storedData valueForKey:@"streetViewImageURL"]]]];
    [cell.imageView setImage:locationImage];

    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    

        
  //      [cell.textLabel setText:@" No Content Saved as of yet"];
        
    
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  if (/* my address row */) {
  //      return  (44.0 + (numberOfLines - 1) * 19.0);
 //   }
    return  (44.0 + (4 - 1) * 19.0);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = self.VcContext;
                                       
        if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        
        [context deleteObject:[self.parkingHistory objectAtIndex:indexPath.row]];
     
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
    /*
      
    [self.parkingHistory removeObjectAtIndex:indexPath.row];
     [self.historyTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    */

    }
  
    
     [self.parkingHistory removeObjectAtIndex:indexPath.row];

    [self.historyTableView reloadData]; // tell table to refresh now
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if ([alertView tag] == 3) {    // it's the Error alert
        if (buttonIndex == 0) {     // and they clicked
            
 //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:carDirectionURL]];
            
        }
    }
    

}


@end

