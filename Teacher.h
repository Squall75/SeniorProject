//
//  Teacher.h
//  DixonNav
//
//  Created by Todd Seabrook on 3/23/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Teacher : NSManagedObject

@property (nonatomic, retain) NSString * tPhone;
@property (nonatomic, retain) NSString * tEmail;
@property (nonatomic, retain) NSString * tBox;
@property (nonatomic, retain) NSString * tOffice;
@property (nonatomic, retain) NSString * tTitle;
@property (nonatomic, retain) NSString * tDepartment;
@property (nonatomic, retain) NSString * tName;


//- (id)initWithValues:(NSString*)tN jTitle:(NSString *)tT depart:(NSString *)tD office:(NSString *)tO box:(NSString *)tB phone:(NSString *)tP email:(NSString *) tE;

@end
