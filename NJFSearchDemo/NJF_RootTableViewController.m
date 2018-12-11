//
//  NJF_RootTableViewController.m
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import "NJF_RootTableViewController.h"
#import "NJF_SeatchController.h"
#import "UIViewController+NJF_StatusBarStyle.h"
#import "SearchHeader.h"

@interface NJF_RootTableViewController ()
@property (nonatomic, strong) NJF_SeatchController *searchVC;
@property (nonatomic, strong) NSArray <NSString *> *_Nonnull dataArray;
@end

@implementation NJF_RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = NJF_Color(51, 51, 51);
    [self.tableView setTableHeaderView:self.searchVC.searchBar];
    self.njf_lightStatusBar = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *ID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - lazy loading

- (NJF_SeatchController *)searchVC{
    if (!_searchVC) {
        _searchVC = [[NJF_SeatchController alloc] init];
        _searchVC.hidesNavigationBarDuringPresentation = YES;
        @weakObj(self)
        _searchVC.searchBlock = ^(NSString * _Nonnull text) {
            @strongObj(self);
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)", text];
            if (!(text.length > 0)) self.searchVC.resultVC.resultArray = @[];
            else self.searchVC.resultVC.resultArray = [self.dataArray filteredArrayUsingPredicate:predicate];
        };
    }
    return _searchVC;
}

- (NSArray <NSString *> *)dataArray{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"txt"];
        NSError *error;
        NSString *countriesString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (!error) _dataArray = [countriesString componentsSeparatedByString:@"\n"];
    }
    return _dataArray;
}
@end
