//
//  FWDContactsViewModel.m
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import "FWDContactsViewModel.h"

@interface FWDContactsViewModel()

@property (nonatomic) NSMutableDictionary <NSString *, NSMutableArray<NSString *> *> *sectionHeaderContactListMap;
 
//@property (nonatomic) NSMutableArray<NSString *> *contactList;

- (void)prepareSectionHeadersContactsMap;

@end

@implementation FWDContactsViewModel

- (instancetype)initWithContactsLibrary:(id<FWDContactsLibrary>)contactsLibrary {
    self = [super init];
    
    if (self) {
        
        self.contactsLibrary = contactsLibrary;
        // Prepare Section Headers List
    }
    return self;
}

- (void)prepareSectionHeadersContactsMap {
    
    _sectionHeaderContactListMap = [[NSMutableDictionary alloc] init];
    
    /*
    for (char a = 'a'; a <= 'z'; a++) {
        [self.sectionHeaderContactListMap setObject:[NSMutableArray arrayWithCapacity:0] forKey:[NSString stringWithFormat:@"%c",a]];
    }
     */
    
    for (FWDContact *aContact in [self.contactsLibrary allContacts]) {
        NSString *beginCharString = [[aContact name] substringToIndex:1];
        
        NSMutableArray<NSString *> *contactListForChar = [self.sectionHeaderContactListMap objectForKey:beginCharString];
        if (!contactListForChar) {
            contactListForChar = [NSMutableArray arrayWithCapacity:0];
        }
        /*
         In iOS Contacts App, Entire Name is shown
        [contactListForChar addObject:[NSString stringWithFormat:@"%@ %@",[aContact firstName],[aContact lastName]]];
         */
        [contactListForChar addObject:[NSString stringWithFormat:@"%@",[aContact name]]];
        
        [self.sectionHeaderContactListMap setObject:contactListForChar forKey:beginCharString];
    }
    
    if (self.sectionHeaderChangeListener) {
        self.sectionHeaderChangeListener();
    }
    
    if (self.contactsChangeListener) {
        self.contactsChangeListener();
    }
    
}

- (void)onRequestSuccess {
    [self prepareSectionHeadersContactsMap];
}

- (void)onRequestFailure:(NSString *)errorDescription {
    
}

- (void)dealloc
{
    NSLog(@"FWDContactsViewController");
}

@end
