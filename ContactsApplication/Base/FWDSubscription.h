//
//  FWDSubscription.h
//  ContactsApplication
//
//  Created by Banisetty Avinash on 24/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 @class FWDSubscription
 
 @brief Generics FWDSubscription class for Bind and Fire properties
 @discussion    This class was designed and implemented to wrap any properties which needs a bind and fire mechanism. When an instance of this class changes, then binded block of code will be called.
 @superclass SuperClass: NSObject\n
 */

@interface FWDSubscription<AnyObject> : NSObject

@property (nonatomic) AnyObject value;

/*! Constructor for this class which accepts the original value as a param
 @param val original value of this class instance
 @return FWDSubscription<Type> type object
 */
- (instancetype)initWithValue:(AnyObject)val;

/*! Bind a listener with this method
 @param listener is a block which Accepts generic Object as param and returns void
 */
- (void)bindWithListener:(void (^)(AnyObject))listener;

/*! Bind a listener with this method and immediately call the listener
 @param listener is a block which Accepts generic Object as param and returns void
 */
- (void)bindWithListenerAndUpdate:(void (^)(AnyObject))listener;

@end

NS_ASSUME_NONNULL_END
