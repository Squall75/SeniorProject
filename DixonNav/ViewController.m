//
//  ViewController.m
//  DixonNav
//
//  Created by Todd Seabrook on 1/25/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import "ViewController.h"
#import "BNRMapPoint.h"
#import "DetailViewController.h"
#import "DatabaseStore.h"

@interface ViewController ()

@property (strong, nonatomic) MKUserLocation *previousLocation;

@end

@implementation ViewController

// When a user clicks on a pinpoint this method is sent to this delegate
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"annotation was selected");
    
    // Create the DetailViewController and push it on top of the navigation controllers stack
    //DetailViewController *detailViewController = [[DetailViewController alloc]init];
    DetailViewController *detailView = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"DetailView"];
    
    // Get the selected pinPoint
    BNRMapPoint *selectedPoint = [view annotation];
    
    // Give detail view controller a point to the selected point
    [detailView setPoint:selectedPoint];
    
    // Push it onto the top of the navigation controller's stack
    [[self navigationController] pushViewController:detailView animated:YES];
    //[self presentViewController:detailViewController animated:YES completion:N]
    
    
}

- (void)placeAnnotations:(CLLocationCoordinate2D )loc
{
    CLLocationCoordinate2D coord = loc;
    coord.latitude = coord.latitude + .0002;
    
    // create three map Annotations
    BNRMapPoint *mp1 = [[BNRMapPoint alloc] initWithCoordinate:coord title:@"First Map Point"];
    
    // Add annotations to the map
    [worldView addAnnotation:mp1];
}

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
    
    CLLocationCoordinate2D loc = [[worldView userLocation]coordinate];
    
    // Place annotations
    [self placeAnnotations:loc];
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
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 150, 150);
        
        //Zoom in on the location of the user
        [worldView setRegion:region animated:YES];
        
        NSLog(@"Inside");

    }
    //NSLog(@"didUpdatedUserLocation outside");
}

- (void)viewDidLoad
{
    // Update the MKMapView location
    [worldView setShowsUserLocation:YES];
    
    
    //[Bronze Challenge]set the display to satellite mode
    //worldView.mapType = MKMapTypeSatellite;
    
    
}

@end
