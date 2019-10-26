//
//  FWDContactsViewController.m
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import "FWDContactsViewController.h"

@interface FWDContactsViewController()

@property (nonatomic) NSMutableArray<NSString *> *filteredSectionHeaderList;
@property (nonatomic) NSMutableDictionary<NSString *, NSMutableArray<NSString *> *> *filteredSectionHeaderContactsMap;
@property (nonatomic) NSMutableDictionary<NSString *, NSArray<NSString *> *> *sortedSectionHeaderContactsMap;
@property (nonatomic) NSArray<NSString *> *sortedSectionHeaderList;

@end

@implementation FWDContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
    
    // Initialize
    self.sortedSectionHeaderContactsMap = [NSMutableDictionary dictionaryWithCapacity:1];
    self.filteredSectionHeaderContactsMap = [NSMutableDictionary dictionaryWithCapacity:1];
}

- (void)setViewModel:(FWDContactsViewModel *)viewModel {
    _viewModel = viewModel;
    [self bindListeners];
}

- (void)prepareUI {
    [self.contactsView setDelegate:self];
    [self.contactsView setDataSource:self];
    [self.searchBar setDelegate:self];
}

- (void)bindListeners {
    
    FWDContactsViewController * __weak blockSelf = self;
    
    self.viewModel.contactsChangeListener = ^void(){
        
        [blockSelf sortSectionHeadersAndContactsListInAscending:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [blockSelf.contactsView reloadData];
        });
    };
}

- (void)sortSectionHeadersAndContactsListInAscending:(BOOL)isAscending {
    
    NSSortDescriptor *sDesc = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:isAscending comparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    self.sortedSectionHeaderList = [NSMutableArray arrayWithArray:[self.viewModel.headersStringSet sortedArrayUsingDescriptors:[NSArray arrayWithObject:sDesc]]];
    
    for (NSString *currentSectionHeader in self.sortedSectionHeaderList) {
        NSMutableArray<NSString *> *sectionContactsList = [self.viewModel.headerToContactsMap objectForKey:currentSectionHeader];
        // Shallow Copy
        NSArray<NSString *> *sortedSectionContactsList = [sectionContactsList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if (isAscending) {
                return [obj1 compare:obj2];
            } else {
                return [obj2 compare:obj1];
            }
        }];
        // Shallow Copy
        [self.sortedSectionHeaderContactsMap setObject:[NSMutableArray arrayWithArray:sortedSectionContactsList] forKey:currentSectionHeader];
    }
}

- (void)filterSortSectionHeadersAndContactsListInAscending:(BOOL)isAscending {
    /*
    NSSortDescriptor *sDesc = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:isAscending comparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    self.filteredSectionHeaderList = [NSMutableArray arrayWithArray:[self.viewModel.headersStringSet sortedArrayUsingDescriptors:[NSArray arrayWithObject:sDesc]]];
     */
    
    [self.filteredSectionHeaderList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (isAscending) {
            return [obj1 compare:obj2];
        } else {
            return [obj2 compare:obj1];
        }
    }];
    
    for (NSString *currentSectionHeader in self.filteredSectionHeaderList) {
        NSMutableArray<NSString *> *sectionContactsList = [self.filteredSectionHeaderContactsMap objectForKey:currentSectionHeader];
        // Shallow Copy
        NSArray<NSString *> *sortedSectionContactsList = [sectionContactsList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if (isAscending) {
                return [obj1 compare:obj2];
            } else {
                return [obj2 compare:obj1];
            }
        }];
        // Shallow Copy
        [self.filteredSectionHeaderContactsMap setObject:[NSMutableArray arrayWithArray:sortedSectionContactsList] forKey:currentSectionHeader];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View Data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    BOOL isSearchInProgress = self.searchBar.text.length > 0 ? YES : NO;
    if (isSearchInProgress) {
        return self.filteredSectionHeaderList.count;
    } else {
        return self.sortedSectionHeaderList.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL isSearchInProgress = self.searchBar.text.length > 0 ? YES : NO;
    
    NSString *sectionCharString = nil;
    NSArray *contactsForSection = nil;
    if (isSearchInProgress) {
        sectionCharString = [self.filteredSectionHeaderList objectAtIndex:section];
        contactsForSection = [self.filteredSectionHeaderContactsMap objectForKey:sectionCharString];
    } else {
        sectionCharString = [self.sortedSectionHeaderList objectAtIndex:section];
        contactsForSection = [self.sortedSectionHeaderContactsMap objectForKey:sectionCharString];
    }
    
    return contactsForSection.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"ContactsTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    BOOL isSearchInProgress = self.searchBar.text.length > 0 ? YES : NO;

    NSString *sectionCharString = nil;
    NSArray *contactsForSection = nil;
    if (isSearchInProgress) {
        sectionCharString = [self.filteredSectionHeaderList objectAtIndex:indexPath.section];
        contactsForSection = [self.filteredSectionHeaderContactsMap objectForKey:sectionCharString];
    } else {
        sectionCharString = [self.sortedSectionHeaderList objectAtIndex:indexPath.section];
        contactsForSection = [self.sortedSectionHeaderContactsMap objectForKey:sectionCharString];
    }

    NSString *contactName = [contactsForSection objectAtIndex:indexPath.row];
    if (contactName) {
        cell.textLabel.text = contactName;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSUInteger headerCount = [self.filteredSectionHeaderContactsMap count];
    NSString *sectionCharString = nil;
    if (headerCount) {
        sectionCharString = [self.filteredSectionHeaderList objectAtIndex:section];
    } else {
        sectionCharString = [self.sortedSectionHeaderList objectAtIndex:section];
    }

    return sectionCharString;
}

# pragma mark - Search Bar Delegate -

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self.filteredSectionHeaderList removeAllObjects];
    [self.filteredSectionHeaderContactsMap removeAllObjects];
    
    if (searchText.length > 0) {
        // Search and sort both Headers and Also Rows
        // First filter contacts and then prepare corresponsing headers
        
        NSArray *allContactNames = [self.sortedSectionHeaderContactsMap.allValues valueForKeyPath:@"@unionOfArrays.self"];
        
         // Predicate will also ultimately iterate. For preparing headers section we need to iterate through filtered items
         // By filtering our selves we can save on iterations for preparing headers.
         /*
        NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchText];
        NSArray *filteredArray = [allContactNames filteredArrayUsingPredicate:namePredicate];
          */
        
        NSMutableSet *headerSet = [[NSMutableSet alloc] init];
        for (NSString *currenContactName in allContactNames) {
            NSRange foundRange = [currenContactName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (foundRange.location != NSNotFound) {
                // Contact should be filtered
                NSString *firstCharString = [currenContactName substringToIndex:1];
                NSMutableArray *mutArr = [self.filteredSectionHeaderContactsMap objectForKey:firstCharString];
                [headerSet addObject:firstCharString];
                if (mutArr) {
                    [mutArr addObject:currenContactName];
                } else {
                    [self.filteredSectionHeaderContactsMap setObject:[NSMutableArray arrayWithObject:currenContactName] forKey:firstCharString];
                }
            }
        }
        
        NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:self.sortUpButton.isSelected];
        self.filteredSectionHeaderList = [NSMutableArray arrayWithArray:[headerSet sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]]];
    } else {
        // Else reset everything
        [self.filteredSectionHeaderContactsMap removeAllObjects];
        [self sortSectionHeadersAndContactsListInAscending:self.sortUpButton.isSelected];
    }
    
    [self.contactsView reloadData];
}

# pragma mark - IBActions -

- (IBAction)sortAscending:(id)sender {
    self.sortUpButton.selected = YES;
    self.sortDownButton.selected = NO;
    
    UIImage * sortEnabled = [UIImage imageNamed:@"sort-up-enabled"];
    [self.sortUpButton setImage:sortEnabled forState:UIControlStateNormal];
    
    UIImage * sortDisabled = [UIImage imageNamed:@"sort-down-disabled"];
    [self.sortDownButton setImage:sortDisabled forState:UIControlStateNormal];
    
    //Ascending
    BOOL isSearchInProgress = self.searchBar.text.length > 0 ? YES : NO;
    if (isSearchInProgress) {
        [self filterSortSectionHeadersAndContactsListInAscending:YES];
    } else {
        [self sortSectionHeadersAndContactsListInAscending:YES];
    }
    
    [self.contactsView reloadData];
}

- (IBAction)sortDescending:(id)sender {
    self.sortDownButton.selected = YES;
    self.sortUpButton.selected = NO;
    
    UIImage * sortDisabled = [UIImage imageNamed:@"sort-up-disabled"];
    [self.sortUpButton setImage:sortDisabled forState:UIControlStateNormal];
    
    UIImage * sortEnabled = [UIImage imageNamed:@"sort-down-enabled"];
    [self.sortDownButton setImage:sortEnabled forState:UIControlStateNormal];
    
    //Descending
    BOOL isSearchInProgress = self.searchBar.text.length > 0 ? YES : NO;
    if (isSearchInProgress) {
        [self filterSortSectionHeadersAndContactsListInAscending:NO];
    } else {
        [self sortSectionHeadersAndContactsListInAscending:NO];
    }
    
    [self.contactsView reloadData];
}

@end
