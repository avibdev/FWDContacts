//
//  FWDContactsViewModel.h
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWDContactsLibrary.h"
#import "FWDSubscription.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWDContactsViewModel : NSObject<FWDContactsLibraryResponseDelegate>

/*! Section list for grouping contacts list */
@property (nonatomic,readonly) NSMutableSet<NSString *> *headersStringSet;
/*! Map of section headers to section contacts */
@property (nonatomic,readonly) NSMutableDictionary<NSString *, NSMutableArray *> *headerToContactsMap;

/*! Raw data of all Contacts */
@property (nonatomic) id<FWDContactsLibrary> contactsLibrary;

/*! Listener called when there is a change in list of fetched contacts */
@property (nonatomic, nullable) void(^contactsChangeListener)(void);

/*!
 @brief Initializer of ContactsViewModel.
 @discussion This method accepts instance of FWDContactsLibrary type.
 @param  contactsLibrary instance of FWDContactsLibrary type
 @return FWDContactsViewModel instance.
 */
- (instancetype)initWithContactsLibrary:(id<FWDContactsLibrary>)contactsLibrary;

@end

NS_ASSUME_NONNULL_END
