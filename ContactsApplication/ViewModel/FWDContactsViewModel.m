//
//  FWDContactsViewModel.m
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import "FWDContactsViewModel.h"

@interface FWDContactsViewModel()

@property (nonatomic) NSMutableSet<NSString *> *headersStringSet;
@property (nonatomic) NSMutableDictionary<NSString *, NSMutableArray *> *headerToContactsMap;
 
- (void)prepareSectionHeadersAndContactsList;

@end

@implementation FWDContactsViewModel

- (instancetype)initWithContactsLibrary:(id<FWDContactsLibrary>)contactsLibrary {
    self = [super init];
    
    if (self) {
        self.contactsLibrary = contactsLibrary;
        self.headersStringSet = [[NSMutableSet alloc] init];
        self.headerToContactsMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)prepareSectionHeadersAndContactsList {
    
    for (FWDContact *aContact in [self.contactsLibrary allContacts]) {
        NSString *beginCharString = [[aContact name] substringToIndex:1];
        [self.headersStringSet addObject:beginCharString];
        
        NSMutableArray<NSString *> *contactsListForHeader = [self.headerToContactsMap objectForKey:beginCharString];
        if (contactsListForHeader) {
            [contactsListForHeader addObject:[aContact name]];
        } else {
            [self.headerToContactsMap setObject:[NSMutableArray arrayWithObject:[aContact name]] forKey:beginCharString];
        }
    }
        
    if (self.contactsChangeListener) {
        self.contactsChangeListener();
    }
    
}

- (void)onRequestSuccess {
    [self prepareSectionHeadersAndContactsList];
}

- (void)onRequestFailure:(NSString *)errorDescription {
    
}

- (void)dealloc
{
    NSLog(@"FWDContactsViewController");
}

@end
