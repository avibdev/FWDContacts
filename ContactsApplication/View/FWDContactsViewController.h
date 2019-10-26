//
//  FWDContactsViewController.h
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWDContactsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 @class FWDContactsViewController
 @brief ViewController class for Contacts
 @discussion    This class was designed and implemented as a viewController for contacts list
 
 @superclass SuperClass: UIViewController\n
 */
@interface FWDContactsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

/*! IBOutlet for contacts table view */
@property (weak, nonatomic) IBOutlet UITableView *contactsView;
/*! IBOutlet for ascending sort button  */
@property (weak, nonatomic) IBOutlet UIButton *sortUpButton;
/*! IBOutlet for descending sort button  */
@property (weak, nonatomic) IBOutlet UIButton *sortDownButton;
/*! IBOutlet for searchbar  */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

/*! viewModel for FWDContactsViewController */
@property (nonatomic) FWDContactsViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
