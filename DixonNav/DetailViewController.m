//
//  DetailViewController.m
//  DixonNav
//
//  Created by Todd Seabrook on 3/22/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRMapPoint.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize point;

/*
 * Setup the subviews to show the properties of point
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [pinTitle setText:[point title]];
    
    NSLog(@"title: %@", [point title]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPoint:(BNRMapPoint *)p
{
    point = p;
    [[self navigationItem] setTitle:[point title]];
}

@end