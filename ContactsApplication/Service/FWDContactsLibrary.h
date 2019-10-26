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

/*!
 @protocol FWDContactsLibraryResponseDelegate
 @brief This Protocol defines success and failure callbacks for a contacts fetch
 @discussion    This protocol was designed and implemented to let delegate know about the error or success result of a contact fetch.
 
 @superclass SuperClass: NSObject\n
 @helps It helps other class FWDContactsLibrary.
 */

@protocol FWDContactsLibraryResponseDelegate <NSObject>

/*! This method is called when a contact list is successfully fetched */
- (void)onRequestSuccess;

/*! This method is called when a contact list fetch ended up in an error
 @param errorDescription This describes the error that occurred during a contact fetch
 */
- (void)onRequestFailure:(NSString * _Nonnull)errorDescription;

@end

/*!
 @protocol FWDContactsLibrary
 @brief This Protocol defines interface for Different Types of Contacts Library
 @discussion    This protocol was designed and implemented to set standard interface for different kind of contact library, which may include Network Fetch, DB Fetch etc.
 
 @superclass SuperClass: NSObject\n
 @helps It helps other class FWDNetworkContactsLibrary.
 */
@protocol FWDContactsLibrary <NSObject>

/*! Response delegate for Contacts Library */
@property (nonatomic) _Nullable id<FWDContactsLibraryResponseDelegate> responseDelegate;

/*! This method is called when a contact list fetch ended up in an error
 @return List of all contacts fetched
 */
- (NSArray<FWDContact *> * _Nonnull)allContacts;

@end

#endif /* FWDContactsLibrary_h */
