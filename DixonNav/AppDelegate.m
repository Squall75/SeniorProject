//
//  AppDelegate.m
//  DixonNav
//
//  Created by Todd Seabrook on 1/25/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DatabaseStore.h"
#import "Teacher.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[DatabaseStore defaultStore]isEmpty] == YES)
         {
             [self buildDatabase];
         }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    BOOL success = [[DatabaseStore defaultStore] saveChanges];
    if(success) {
        NSLog(@"Saved all of the BNRItems");
    } else {
        NSLog(@"Could not save any of the BNRItems");
    }
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 * This method will take the data contained CBUDirectory.txt and populate our store.data with the
 * data model stated in CBUBuildings.xcdatamododeled and will be contained in DatabaseStore.
 */
- (void)buildDatabase
{
    //NSLog(@"Build database");
    // Break it up into an array of strings sepearate by newline character
    NSArray *strArray = [self readFile];
    NSMutableArray *tBlock = [[NSMutableArray alloc] init];
    //NSMutableArray *teachers = [[NSMutableArray alloc] init];
    
    // Teacher attributes
    NSString *tName = @"";
    NSString *tTitle = @"";
    NSString *tDepartment = @"";
    NSString *tOffice = @"";
    NSString *tBox = @"";
    NSString *tPhone = @"";
    NSString *tEmail = @"";
    
    /* Walk through the text file and create a teacher object for each block of data.
     * Then add this new teacher object to the store.data file
     */
    
    for (NSString *strLine in strArray)
    {
        //Make sure the line isn't blank
        if ([strLine isEqualToString:@""])
        {
            //NSLog(@"Blank");
        }
        else {
            //Add current line to our block
            [tBlock addObject:strLine];
        }
        //Add the line of text until it contains 7 lines
        if ([tBlock count] == 7)
        {
            
            tName = [tBlock objectAtIndex:0];
            tTitle = [tBlock objectAtIndex:1];
            tDepartment = [tBlock objectAtIndex:2];
            tOffice = [tBlock objectAtIndex:3];
            tBox = [tBlock objectAtIndex:4];
            tPhone = [tBlock objectAtIndex:5];
            tEmail = [tBlock objectAtIndex:6];
            
            //Creat our teacher object
            Teacher *newT = [[DatabaseStore alloc] createTeacher];
            
            [newT setTName:tName];
            [newT setTTitle:tTitle];
            [newT setTDepartment:tDepartment];
            [newT setTOffice:tOffice];
            [newT setTBox:tBox];
            [newT setTPhone:tPhone];
            [newT setTEmail:tEmail];
            
            //NSLog(@"Block");
            
            // Reset our TBlock
            [tBlock removeAllObjects];
            
            
          
            //create our teacher object
            //Teacher *temp = [[Teacher alloc] initWithValues:tName jTitle:tTitle depart:tDepartment office:tOffice box:tBox phone:tPhone email:tEmail];
            
        }
        
        //NSLog(@"%@", strLine);
    }
    
    /* Lets look at the objects in our database
    DatabaseStore *temp = [DatabaseStore defaultStore];
    NSArray *list = [temp allItems];
    NSLog(@"Count list: %tu", [list count]);
    for (int i = 0; i < [list count]; i++)
    {
       Teacher *t = [list objectAtIndex:i];
        NSLog(@"Teacher: %@", [t tName]);
    }
     */
    
    [[DatabaseStore defaultStore] saveChanges];
    
}

-(NSArray*)readFile

{
    // Prepare to read in text file
    NSString *fileName = @"CBUDirectory";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    
    NSString *readIn = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:NULL];
    
    // Break it up into an array of strings sepearate by newline character
    NSArray *strArray = [readIn componentsSeparatedByString:@"\n"];
    
    return strArray;

}

@end
