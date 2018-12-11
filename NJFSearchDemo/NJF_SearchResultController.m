//
//  NJF_SearchResultController.m
//  NJFSearchDemo
//
//  Created by niujf on 2018/12/10.
//  Copyright © 2018年 niujf. All rights reserved.
//

#import "NJF_SearchResultController.h"

@interface NJF_SearchResultController ()

@end

@implementation NJF_SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - setter and getter

- (void)setResultArray:(NSArray<NSString *> *)resultArray{
    if (resultArray.count < 1) {
        return;
    }
    _resultArray = resultArray;
    [self.tableView reloadData];
}

#pragma mark - Table view data source
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count > 0 ? self.resultArray.count : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *ID = @"ResultCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.resultArray[indexPath.row];
    return cell;
}

@end
