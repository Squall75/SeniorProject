//
//  DatabaseStore.h
//  DixonNav
//
//  Created by Todd Seabrook on 3/23/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class Teacher;
@interface DatabaseStore : NSObject
{
    NSMutableArray *allItems;
}

@property (readonly, strong, nonatomic) NSManagedObjectContext *context;
@property (readonly, strong, nonatomic) NSManagedObjectModel *model;

+ (DatabaseStore *)defaultStore; // makes sure only one instance of Database store is around

- (NSArray *)allItems;

- (Teacher *)createTeacher;

- (void)loadAllItems;

- (NSString *)itemArchivePath;

- (BOOL)saveChanges;

- (BOOL)isEmpty;

- (NSArray *)getBuilding:(NSString *)building;

@end
