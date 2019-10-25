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

@property (nonatomic,readonly) NSMutableDictionary <NSString *, NSMutableArray<NSString *> *> *sectionHeaderContactListMap;
 
//@property (nonatomic,readonly) NSMutableArray<NSString *> *contactList;
@property (nonatomic) id<FWDContactsLibrary> contactsLibrary;

@property (nonatomic, nullable) void(^sectionHeaderChangeListener)(void);
@property (nonatomic, nullable) void(^contactsChangeListener)(void);

- (instancetype)initWithContactsLibrary:(id<FWDContactsLibrary>)contactsLibrary;

@end

NS_ASSUME_NONNULL_END