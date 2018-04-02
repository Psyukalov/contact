//
//  TableView.m
//
//
//  Created by Vladimir Psyukalov on 07.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "TableView.h"


@interface TableView ()

@property (strong, nonatomic) NSMutableArray<NSString *> *cellReuseIdentifiers;
@property (strong, nonatomic) NSMutableArray<NSString *> *viewReuseIdentifiers;

@end


@implementation TableView

#pragma mark - Class methods

- (void)reloadDataAnimated:(BOOL)animated {
    [self reloadDataAnimated:animated completion:nil];
}

- (void)reloadDataAnimated:(BOOL)animated completion:(void (^)(void))completion {
    if (animated) {
        self.hidden = YES;
    }
    [super reloadData];
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setCellsHidden:YES animated:NO completion:nil];
            self.hidden = NO;
            [self setCellsHidden:NO animated:YES completion:^{
                if (completion) {
                    completion();
                }
            }];
        });
    }
}

- (void)registerCellClass:(Class)cellClass {
    NSString *cellReuseIdentifier = NSStringFromClass(cellClass);
    [_cellReuseIdentifiers addObject:cellReuseIdentifier];
    [self registerNib:[UINib nibWithNibName:cellReuseIdentifier bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
}

- (void)registerViewClass:(Class)viewClass {
    NSString *viewReuseIdentifier = NSStringFromClass(viewClass);
    [_viewReuseIdentifiers addObject:viewReuseIdentifier];
    [self registerNib:[UINib nibWithNibName:viewReuseIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:viewReuseIdentifier];
}

- (nullable __kindof UITableViewCell *)dequeueReusableCellWithIndex:(NSUInteger)index {
    return [self dequeueReusableCellWithIdentifier:_cellReuseIdentifiers[index]];
}

- (nullable __kindof UIView *)dequeueReusableViewWithIndex:(NSUInteger)index {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:_viewReuseIdentifiers[index]];
}

- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated {
    [self setCellsHidden:hidden animated:animated completion:nil];
}

- (void)setCellsHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden = hidden && !animated;
        if (self.visibleCells.count > 0) {
            CGFloat alpha = hidden ? 0.f : 1.f;
            for (NSUInteger i = 0; i <= self.visibleCells.count - 1; i++) {
                UITableViewCell *cell = self.visibleCells[i];
                if (animated) {
                    [UIView animateWithDuration:.64f delay:i * .08f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        cell.alpha = alpha;
                    } completion:^(BOOL finished) {
                        if (i == self.visibleCells.count - 1 && completion) {
                            completion();
                        }
                    }];
                } else {
                    cell.alpha = alpha;
                    if (i == self.visibleCells.count - 1 && completion) {
                        completion();
                    }
                }
            }
        } else if (completion) {
            completion();
        }
    });
}

- (void)updatesCompletion:(void (^)(void))completion {
    [self beginUpdates];
    if (completion) {
        completion();
    }
    [self endUpdates];
}

#pragma mark - Overriding properties

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    CGFloat y = self.contentOffset.y;
    if (self.contentSize.height - y < self.frame.size.height) {
        if ([self.delegate respondsToSelector:@selector(didScrollToBottomInTableView:)]) {
            [(id)self.delegate didScrollToBottomInTableView:self];
        }
    }
}

#pragma mark - Overriding methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)reloadData {
    [self reloadDataAnimated:NO];
}

#pragma mark - Other methods

- (void)setup {
    _cellReuseIdentifiers = [NSMutableArray new];
    _viewReuseIdentifiers = [NSMutableArray new];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshControl_VC) forControlEvents:UIControlEventValueChanged];
    self.tableHeaderView = [UIView new];
    self.tableFooterView = [UIView new];
    self.alwaysBounceVertical = NO;
}

#pragma mark - Actions

- (void)refreshControl_VC {
    [self.refreshControl beginRefreshing];
    if ([self.delegate respondsToSelector:@selector(didRefreshControlBeginRefreshingInTableView:)]) {
        [(id)self.delegate didRefreshControlBeginRefreshingInTableView:self];
    }
}

@end
