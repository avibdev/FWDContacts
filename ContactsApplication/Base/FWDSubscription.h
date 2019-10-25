//
//  FWDSubscription.h
//  ContactsApplication
//
//  Created by Banisetty Avinash on 24/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FWDSubscription<AnyObject> : NSObject

@property (nonatomic) AnyObject value;

- (instancetype)initWithValue:(AnyObject)val;
- (void)bindWithListener:(void (^)(AnyObject))listener;
- (void)bindWithListenerAndUpdate:(void (^)(AnyObject))listener;

@end

NS_ASSUME_NONNULL_END
