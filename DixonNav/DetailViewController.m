//
//  DetailViewController.m
//  DixonNav
//
//  Created by Todd Seabrook on 3/22/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRMapPoint.h"
#import "DatabaseStore.h"
#import "Teacher.h"

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
    
    //NSArray *store = [[DatabaseStore defaultStore] allItems];
    
    NSArray *teachers = [[DatabaseStore defaultStore] getBuilding:[point title]];
    
    NSString *text = @"";
    NSString *name, *title, *department, *office, *box, *phone, *email;
    
    
    
    for (int i = 0; i < [teachers count]; i++)
    {
        //NSLog(@"%@", [[teachers objectAtIndex:i]tOffice]);
        name = [[teachers objectAtIndex:i]tName];
        title = [[teachers objectAtIndex:i]tTitle];
        department =[[teachers objectAtIndex:i]tDepartment];
        office = [[teachers objectAtIndex:i]tOffice];
        box = [[teachers objectAtIndex:i]tBox];
        phone = [[teachers objectAtIndex:i]tPhone];
        email = [[teachers objectAtIndex:i]tEmail];
        //text= [text stringByAppendingString:[[teachers objectAtIndex:i]tName]];
        //title =
        //text = [text stringByAppendingString:@"\n"];
        
        text = [text stringByAppendingString:name];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:title];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:department];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:office];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:box];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:phone];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:email];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"\n"];
        
        
        
    }
    
    
    [pinText setText:text];
    
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
