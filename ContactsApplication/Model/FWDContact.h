//
//  FWDContact.h
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 @class FWDContact
 @brief Model class for Contact
 @discussion    This class was designed and implemented as a model for contact
 
 @superclass SuperClass: NSObject\n
 */
@interface FWDContact : NSObject

/*! Full name of the contact */
@property (nonatomic, copy, readonly) NSString *name;

/*! first name of the contact */
@property (nonatomic, copy, readonly) NSString *firstName;

/*! last name of the contact */
@property (nonatomic, copy, readonly) NSString *lastName;

/*!
 Constructor for this class
 @param contactName accepts contactName
 */
- (instancetype)initWithName:(NSString *)contactName;

@end

NS_ASSUME_NONNULL_END
