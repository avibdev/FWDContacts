//
//  FWDContact.m
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import "FWDContact.h"

@interface FWDContact()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@end

@implementation FWDContact

- (instancetype)initWithName:(NSString *)contactName {
    
    if (contactName) {
        self = [super init];
        _name = [contactName copy];
    } else {
        self = nil;
    }
    
    self.firstName = @"";
    self.lastName = @"";
    
    NSArray *nameComponents = [self.name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *fName = [nameComponents firstObject];
    NSString *lName = [nameComponents lastObject];
    
    if (fName) {
        self.firstName = fName;
    }
    if (lName) {
        self.lastName = lName;
    }

    return self;
}

@end
