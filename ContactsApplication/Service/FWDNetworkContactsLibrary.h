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

@interface FWDNetworkContactsLibrary : NSObject<FWDContactsLibrary>

@property (nonatomic, copy) NSString *urlString;

- (void)fetchContacts;

@end

NS_ASSUME_NONNULL_END
