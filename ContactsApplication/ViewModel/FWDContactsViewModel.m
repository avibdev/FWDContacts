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

/*! Prepare headers and contact list. Call the listener for any contact list updation */
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

# pragma mark - FWDContactsLibraryResponseDelegate methods -

- (void)onRequestSuccess {
    [self prepareSectionHeadersAndContactsList];
}

- (void)onRequestFailure:(NSString *)errorDescription {
    /// Show any popups on contacts fetch failure
}

@end
