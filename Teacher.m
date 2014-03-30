//
//  Teacher.m
//  DixonNav
//
//  Created by Todd Seabrook on 3/23/14.
//  Copyright (c) 2014 Christian Brothers University. All rights reserved.
//

#import "Teacher.h"


@implementation Teacher

@dynamic tPhone;
@dynamic tEmail;
@dynamic tBox;
@dynamic tOffice;
@dynamic tTitle;
@dynamic tDepartment;
@dynamic tName;

// To configure out teacher object after it has been created.
/*
- (void)awakeFromFetch
{
    [super awakeFromFetch];
}

// When creating a new teacher object this is sent
- (void)awakeFromInsert
{
    [super awakeFromInsert];
}
*/
/*
//Create our teacher object with all of its values
- (id)initWithValues:(NSString *)tN jTitle:(NSString *)tT depart:(NSString *)tD office:(NSString *)tO box:(NSString *)tB phone:(NSString *)tP email:(NSString *)tE
{
    self = [super init];
    if (self) {
        [self setTName:tN];
        [self setTTitle:tT];
        [self setTDepartment:tD];
        [self setTOffice:tO];
        [self setTBox:tB];
        [self setTPhone:tP];
        [self setTEmail:tE];
    
    return self;
}
*/
@end
