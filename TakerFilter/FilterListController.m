//
//  FilterListController.m
//  TakerFilter
//
//  Created by devjia on 2018/3/14.
//  Copyright © 2018年 VNI. All rights reserved.
//

#import "FilterListController.h"
#import "FilterCell.h"
#import "ViewController.h"

@interface FilterListController ()

@property (nonatomic, strong) NSArray *filterNames;

@end

@implementation FilterListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一闪";
    _filterNames = @[@"勃朗峰", @"博盖利亚", @"富士山", @"落基山脉", @"马里布", @"曼哈顿", @"帕萨迪纳", @"派克", @"千代田", @"切尔西", @"圣地亚哥", @"檀香山", @"威尼斯", @"西雅图", @"新宿", @"休斯顿", @"银座", @"珠穆朗玛", @"筑地"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filterNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
    cell.filterNameLabel.text = _filterNames[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *controller = [segue destinationViewController];
    controller.filterName = _filterNames[self.tableView.indexPathForSelectedRow.row];
}

@end
