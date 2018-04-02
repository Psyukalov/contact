//
//  TableView.h
//
//
//  Created by Vladimir Psyukalov on 07.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@class TableView;


@protocol TableViewDelegate <NSObject>

@optional

- (void)didRefreshControlBeginRefreshingInTableView:(TableView *)tableView;

- (void)didScrollToBottomInTableView:(TableView *)tableView;

@end


@interface TableView : UITableView

- (void)reloadDataAnimated:(BOOL)animated;
- (void)reloadDataAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (void)registerCellClass:(Class)cellClass;
- (void)registerViewClass:(Class)viewClass;

- (__kindof UITableViewCell *)dequeueReusableCellWithIndex:(NSUInteger)index;
- (__kindof UIView *)dequeueReusableViewWithIndex:(NSUInteger)index;

- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)updatesCompletion:(void (^)(void))completion;

@end
