//
//  FWDSubscription.m
//  ContactsApplication
//
//  Created by Banisetty Avinash on 24/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import "FWDSubscription.h"

@interface FWDSubscription<AnyObject>()

@property (nonatomic) void (^block)(AnyObject);

@end

@implementation FWDSubscription

-(instancetype)initWithValue:(id)val {
    self = [super init];
    
    if (self) {
        self.value = val;
    }
    
    return self;
}

- (void)bindWithListener:(void (^)(id _Nonnull))listener {
    self.block = listener;
}

- (void)bindWithListenerAndUpdate:(void (^)(id _Nonnull))listener {
    self.block = listener;
    self.block(self.value);
}

- (void)setValue:(id)value {
    _value = value;
}

@end
