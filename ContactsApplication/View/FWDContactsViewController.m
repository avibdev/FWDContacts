//
//  FWDContactsViewController.m
//  ContactsApplication
//
//  Created by Banisetty Avinash on 22/10/19.
//  Copyright © 2019 Fresh Works Demo. All rights reserved.
//

#import "FWDContactsViewController.h"

@interface FWDContactsViewController()

@property (nonatomic) NSArray *filteredSectionHeaderContactsMap;
@property (nonatomic) NSArray *sortedSectionHeaderContactsMap;
@property (nonatomic) NSArray *sortedSectionHeaderList;

@end

@implementation FWDContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
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
    self.viewModel.sectionHeaderChangeListener = ^void() {
        blockSelf.sortedSectionHeaderList = [blockSelf.viewModel.sectionHeaderContactListMap.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [blockSelf.contactsView reloadSectionIndexTitles];
        });
    };
    self.viewModel.contactsChangeListener = ^void(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [blockSelf.contactsView reloadData];
        });
    };
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
    return self.sortedSectionHeaderList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionCharString = [self.sortedSectionHeaderList objectAtIndex:section];
    NSMutableArray *contactsForSection = [self.viewModel.sectionHeaderContactListMap objectForKey:sectionCharString];
    return contactsForSection.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"ContactsTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSString *sectionCharString = [self.sortedSectionHeaderList objectAtIndex:indexPath.section];
    NSMutableArray *contactsForSection = [self.viewModel.sectionHeaderContactListMap objectForKey:sectionCharString];
    
    NSString *contactName = [contactsForSection objectAtIndex:indexPath.row];
    if (contactName) {
        cell.textLabel.text = contactName;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionCharString = [self.sortedSectionHeaderList objectAtIndex:section];
    return sectionCharString;
}

# pragma mark - Search Bar Delegate -

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length > 0) {
        // Search and sort both Headers and Also Rows
        // First filter contacts and then prepare corresponsing headers
        NSString *filterString = @"%K CONTAINS[cd] %@";
        NSPredicate *namePredicate = [NSPredicate predicateWithFormat:filterString,@"SELF",searchText];
        NSArray *allContactNames = [self.viewModel.sectionHeaderContactListMap.allValues valueForKeyPath:@"@unionOfArrays.self"];
        NSLog(@"allContactNames is %@", allContactNames);
        NSArray *filteredArray = [allContactNames filteredArrayUsingPredicate:namePredicate];
        NSLog(@"filteredArray is %@", filteredArray);
    }
}

# pragma mark - IBActions -

- (IBAction)sortAscending:(id)sender {
    if (!self.sortUpButton.isSelected) {
        self.sortUpButton.selected = YES;
        self.sortDownButton.selected = NO;

        UIImage * sortEnabled = [UIImage imageNamed:@"sort-up-enabled"];
        [self.sortUpButton setImage:sortEnabled forState:UIControlStateNormal];
        
        UIImage * sortDisabled = [UIImage imageNamed:@"sort-down-disabled"];
        [self.sortDownButton setImage:sortDisabled forState:UIControlStateNormal];
        
        //Ascending
        self.sortedSectionHeaderList = [self.viewModel.sectionHeaderContactListMap.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        [self.contactsView reloadData];
    }
}

- (IBAction)sortDescending:(id)sender {
    if (!self.sortDownButton.isSelected) {
        self.sortDownButton.selected = YES;
        self.sortUpButton.selected = NO;
        
        UIImage * sortDisabled = [UIImage imageNamed:@"sort-up-disabled"];
        [self.sortUpButton setImage:sortDisabled forState:UIControlStateNormal];
        
        UIImage * sortEnabled = [UIImage imageNamed:@"sort-down-enabled"];
        [self.sortDownButton setImage:sortEnabled forState:UIControlStateNormal];
        
        //Descending
        self.sortedSectionHeaderList = [self.viewModel.sectionHeaderContactListMap.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj2 compare:obj1];
        }];
        [self.contactsView reloadData];
    }
}

@end
