//
//  DatabaseStore.m
//  DixonNav
//
//  Created by Todd Seabrook on 3/23/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import "DatabaseStore.h"
#import "Teacher.h"

@implementation DatabaseStore

+ (DatabaseStore *)defaultStore
{
    static DatabaseStore *defaultStore = nil;
    if (!defaultStore)
        defaultStore = [[super allocWithZone:nil] init];
    
    return defaultStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // Read in CbuBuildings.xcdatamodeld
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // Where does the SQLite file go
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        // Create the managed object context
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        // Turn off undo
        [context setUndoManager:nil];
        
        [self loadAllItems];
    }
    
    return self;
}

- (void)loadAllItems
{
    if (!allItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Teacher"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"tName"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    NSLog(@"itemArchivePath: %@", [documentDirectory stringByAppendingPathComponent:@"store.data"]);
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

/* Sends the message save to the NSManagedObjectContext.
 * The context then will update all of the recoreds in store.data
 * with any changes since the last time it was saved.
 */
- (BOOL)saveChanges
{
    NSLog(@"Save Changes");
    NSError *err = nil;
    BOOL successful = [context save:&err];
    
    NSLog(@"%@", err);
    
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

- (NSArray *)allItems
{
    return allItems;
}

/*
 * Asks NSManagedObjectContext to make us a new teacher object and insert it into
 * out running list of teachers.
 */
- (Teacher *)createTeacher
{
    //NSLog(@"Adding a new teacher");
    
    Teacher *t = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:context];
    
    [allItems addObject:t];

    return t;
}

- (BOOL)isEmpty
{
    BOOL t = FALSE;
    if (allItems == nil || [allItems count] == 0)
        {
            t = TRUE;
        }
    return t;
}
@end