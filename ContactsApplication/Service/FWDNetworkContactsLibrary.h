//
//  FWDNetworkContactsLibrary.h
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWDContactsLibrary.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 @class FWDNetworkContactsLibrary
 
 @brief FWDNetworkContactsLibrary implements FWDContactsViewModel to fetch contacts
 
 @discussion    This class was designed and implemented to fetch all contacts through a rest network call
 
 @superclass SuperClass: NSObject\n
 @helper    FWDContactsLibrary helps this class
 */

@interface FWDNetworkContactsLibrary : NSObject<FWDContactsLibrary>

/*! URL to fetch Contacts */
@property (nonatomic, copy)  NSString * _Nonnull urlString;

/*! This method is called to fetch contacts from a rest call with URL set. */
- (void)fetchContacts;

@end

NS_ASSUME_NONNULL_END
