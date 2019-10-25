//
//  FWDContactsLibrary.h
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#ifndef FWDContactsLibrary_h
#define FWDContactsLibrary_h

#import "FWDContact.h"

@protocol FWDContactsLibraryResponseDelegate <NSObject>

- (void)onRequestSuccess;
- (void)onRequestFailure:(NSString *)errorDescription;

@end

@protocol FWDContactsLibrary <NSObject>

@property (nonatomic) id<FWDContactsLibraryResponseDelegate> responseDelegate;
- (NSArray<FWDContact *> *)allContacts;

@end

#endif /* FWDContactsLibrary_h */
