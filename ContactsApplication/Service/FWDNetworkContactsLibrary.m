//
//  FWDNetworkContactsLibrary.m
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import "FWDNetworkContactsLibrary.h"
#import <UIKit/UIKit.h>

@interface FWDNetworkContactsLibrary()

@property (nonatomic) NSMutableArray<FWDContact *> *contactsList;

- (void)populateContactsWithReponse:(NSArray *)reponseList;

@end

@implementation FWDNetworkContactsLibrary

@synthesize responseDelegate;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.contactsList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)fetchContacts {
    
    // Set Any Params for URL Request
    NSAssert(self.urlString != nil, @"URL should be set before you invoke a network request !!!");
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
                                      dataTaskWithRequest:urlRequest
                                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                          //First check for any errors
                                          if (error) {
                                              // Inform the delegate about Error to take appropriate action
                                              NSString *errorDescription = [NSString stringWithFormat:@"ContactList Request Error : %@",error.localizedDescription];
                                              [self.responseDelegate onRequestFailure:errorDescription];
                                          } else {
                                              NSHTTPURLResponse *urlResponseTC = (NSHTTPURLResponse *)response;
                                              if (urlResponseTC.statusCode == 200) {
                                                  // Inform the delegate about Success to take appropriate action
                                                  NSError *parseError = nil;
                                                  NSArray *jsonResponseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:NSJSONReadingAllowFragments error:&parseError];
                                                  if (parseError) {
                                                      if (self.responseDelegate) {
                                                          NSString *errorDescription = [NSString stringWithFormat:@"ContactList download data Parse Error"];
                                                          [self.responseDelegate onRequestFailure:errorDescription];
                                                      }
                                                  } else {
                                                      [self populateContactsWithReponse:jsonResponseDict];
                                                  }
                                              } else {
                                                  // Failure Response
                                                  NSString *errorDescription = [NSString stringWithFormat:@"URL Response Error : %@", [NSHTTPURLResponse localizedStringForStatusCode:urlResponseTC.statusCode]];
                                                  [self.responseDelegate onRequestFailure:errorDescription];
                                              }
                                          }
                                      }];
    [dataTask resume];
}

- (NSArray<FWDContact *> *)allContacts {
    return [self.contactsList copy];
}

- (void)populateContactsWithReponse:(NSArray *)reponseList {
    
    for (NSDictionary *contactEntry in reponseList) {
        NSString *name = [contactEntry objectForKey:@"name"];
        if (name) {
            FWDContact *contact = [[FWDContact alloc] initWithName:name];
            if (contact) {
                [self.contactsList addObject:contact];
            }
        }
    }
    
    [self.responseDelegate onRequestSuccess];
}

@end
