//
//  ViewController.m
//  DixonNav
//
//  Created by Todd Seabrook on 1/25/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import "ViewController.h"
#import "BNRMapPoint.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    // Create an instance of BNRMapPoint with the current data
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    
    // Add it to the map view
    [worldView addAnnotation:mp];
    
    // Zoom the region to this location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    // Reset the UI
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // This method isn't implemented yet - but will be soon
    [self findLocation];
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    // Show the direction that the user is facing
    [worldView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:NO];
}

/*
 * A message, states that the user's location has been updated
 */
- (void)mapView: (MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //Get the coordinates of the user's location
    CLLocationCoordinate2D loc = [userLocation coordinate];
    
    //Set the area that we would like to zoom in on
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    
    //Zoom in on the location of the user
    [worldView setRegion:region animated:YES];
}

- (void)viewDidLoad
{
    // Update the MKMapView location
    [worldView setShowsUserLocation:YES];
    
    //[Bronze Challenge]set the display to satellite mode
    //worldView.mapType = MKMapTypeSatellite;
    
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    // Call the init method implemented by the superclass
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Create location manager object
        locationManager = [[CLLocationManager alloc] init];
        
        [locationManager setDelegate:self];
        
        // And we want it to be as accurate as possible
        // regardless of how much time/power it takes
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
    
    // How many seconds ago was this new location created?
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    // CLLocation will return the last found location of the device
    // first, you don't want that data in this case.
    // If this location was made more than 3 minutes ago, ignore it.
    if (t < -180) {
        // This is chached data, you don't want it, keep looking
        return;
    }
    
    [self foundLocation:newLocation];
    
}

/*
 * delegate is unsafe unretained and needs to be removed when
 * distroyed. 
 */
- (void)dealloc
{
    // Tell the location manager to stop sending us messages
    [locationManager setDelegate:nil];
}

/*
 * CLLocationManager has failed to find its location
 * This message will be sent to its delegate
 */
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}



@end
