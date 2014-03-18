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

@property (strong, nonatomic) MKUserLocation *previousLocation;

@end

@implementation ViewController

/*
 * If the client clicks on the segmented controller. Check to see what changes need to be done to 
 * reflect the clients click
 */
- (void)changeSeg
{
    if (worldView.mapType == MKMapTypeStandard)
    {
        worldView.mapType = MKMapTypeSatellite;
    }
    else if (worldView.mapType == MKMapTypeSatellite)
    {
        worldView.mapType = MKMapTypeStandard;
    }
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
    
    // Update the map if the client has moved a signifcant amount from their last position
    if (self.previousLocation == nil || [userLocation.location distanceFromLocation:_previousLocation.location] > 30.0)
    {
        _previousLocation = userLocation;
        
        //Set the area that we would like to zoom in on
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
        
        //Zoom in on the location of the user
        [worldView setRegion:region animated:YES];

    }
}

- (void)viewDidLoad
{
    // Update the MKMapView location
    [worldView setShowsUserLocation:YES];
    
    //[Bronze Challenge]set the display to satellite mode
    //worldView.mapType = MKMapTypeSatellite;
    
    
}



@end
