//
//  HistoryView.m
//  contact
//
//  Created by Vladimir Psyukalov on 22.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "HistoryView.h"

#import "TableView.h"

#import "HistoryTableViewCell.h"


@interface HistoryView () <UITableViewDataSource, TableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet TableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;

@property (weak, nonatomic) IBOutlet UILabel *historyLabel;

@end


@implementation HistoryView

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _historyLabel.text = LOCALIZE(@"hv_label_0");
    _tableView.refreshControl = nil;
    _tableView.tableHeaderView = _tableHeaderView;
    [_tableView registerCellClass:[HistoryTableViewCell class]];
    _tableView.tableFooterView.frame = CGRectMake(0.f, 0.f, 0.f, 16.f);
}

#pragma mark - UITableViewDataSource, TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 32;
}

- (UITableViewCell *)tableView:(TableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIndex:0];
    return cell;
}

- (void)didScrollToBottomInTableView:(TableView *)tableView {
    // TODO:
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // TODO:
}

- (IBAction)closeButton_TUI:(UIButton *)sender {
    if (self.didCloseViewCompletion) {
        self.didCloseViewCompletion();
    }
}

@end
