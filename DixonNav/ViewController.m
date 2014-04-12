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
    
    // Get the selected pinPoint
    BNRMapPoint *selectedPoint = [view annotation];
    
    // Prevent client from clicking on their own location
    if (![[selectedPoint title] isEqualToString:(@"Current Location")])
    {
    
        // Create the DetailViewController and push it on top of the navigation controllers stack
        //DetailViewController *detailViewController = [[DetailViewController alloc]init];
        DetailViewController *detailView = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"DetailView"];
    
        // Get the selected pinPoint
        //BNRMapPoint *selectedPoint = [view annotation];
    
        // Give detail view controller a point to the selected point
        [detailView setPoint:selectedPoint];
    
        // Push it onto the top of the navigation controller's stack
        [[self navigationController] pushViewController:detailView animated:YES];
        //[self presentViewController:detailViewController animated:YES completion:N]
    }
    
    
}

- (void)placeAnnotations:(CLLocationCoordinate2D )loc
{
    // Cooper-Wilson
    CLLocationDegrees lat = 35.126770;
    CLLocationDegrees longitude = -89.981684;
    CLLocationCoordinate2D cwLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *cw = [[BNRMapPoint alloc] initWithCoordinate:cwLoc title:@"Cooper-Wilson"];
    
    // St. Joseph
    lat = 35.127419;
    longitude = -89.982417;
    CLLocationCoordinate2D joLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *jo = [[BNRMapPoint alloc] initWithCoordinate:joLoc title:@"St. Joseph"];
    
    // Buckman
    lat = 35.127420;
    longitude = -89.983085;
    CLLocationCoordinate2D buLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *bu = [[BNRMapPoint alloc] initWithCoordinate:buLoc title:@"Buckman"];
    
    // Assisi
    lat = 35.127398;
    longitude = -89.981668;
    CLLocationCoordinate2D asLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *as = [[BNRMapPoint alloc] initWithCoordinate:asLoc title:@"Assisi"];
    
    // Nolan
    lat = 35.127750;
    longitude = -89.981332;
    CLLocationCoordinate2D noLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *no = [[BNRMapPoint alloc] initWithCoordinate:noLoc title:@"Nolan"];
    
    // Barry Hall
    lat = 35.127989;
    longitude = -89.982492;
    CLLocationCoordinate2D baLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *ba = [[BNRMapPoint alloc] initWithCoordinate:baLoc title:@"Barry Hall"];
    
    // Kenrick
    lat = 35.128291;
    longitude = -89.982482;
    CLLocationCoordinate2D keLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *ke = [[BNRMapPoint alloc] initWithCoordinate:keLoc title:@"Kenrick"];
    

    // Plough Library
    lat = 35.127974;
    longitude = -89.981994;
    CLLocationCoordinate2D plLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *pl = [[BNRMapPoint alloc] initWithCoordinate:plLoc title:@"Plough Library"];
    
    // Thomas Center
    lat = 35.128361;
    longitude = -89.981841;
    CLLocationCoordinate2D thLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *th = [[BNRMapPoint alloc] initWithCoordinate:thLoc title:@"Thomas Center"];
    
    // Rozier
    lat = 35.128991;
    longitude = -89.982033;
    CLLocationCoordinate2D roLoc = CLLocationCoordinate2DMake(lat, longitude);
    BNRMapPoint *ro = [[BNRMapPoint alloc] initWithCoordinate:roLoc title:@"Rozier"];

    
    // Add annotations to the map
    [worldView addAnnotation:cw];
    [worldView addAnnotation:jo];
    [worldView addAnnotation:bu];
    [worldView addAnnotation:as];
    [worldView addAnnotation:no];
    [worldView addAnnotation:ba];
    [worldView addAnnotation:ke];
    [worldView addAnnotation:pl];
    [worldView addAnnotation:th];
    [worldView addAnnotation:ro];
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
