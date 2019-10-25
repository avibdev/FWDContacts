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

@interface FWDContactsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contactsView;
@property (weak, nonatomic) IBOutlet UIButton *sortUpButton;
@property (weak, nonatomic) IBOutlet UIButton *sortDownButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic) FWDContactsViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
