//
//  ChatView.m
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ChatView.h"

#import "VPPointsActivityIndicatorView.h"

#import "OwnerMessageTableViewCell.h"


@interface ChatView () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet TableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *tableFooterView;
@property (weak, nonatomic) IBOutlet UIView *roundedView;

@property (weak, nonatomic) IBOutlet VPPointsActivityIndicatorView *pointsActivityIndicatoreView;

@end


@implementation ChatView

#pragma mark - Class properties

- (void)setMessages:(NSMutableArray<Message *> *)messages {
    _messages = messages;
    [self refresh];
}

#pragma mark - Class methods

- (void)addMessage:(Message *)message {
    [_messages addObject:message];
    NSUInteger index = [_messages indexOfObject:message];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)removeMessage:(Message *)message {
    NSUInteger index = [_messages indexOfObject:message];
    [_messages removeObject:message];
    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)receiverIsTypingText:(BOOL)isTypingText {
    [UIView animateWithDuration:.32f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _tableView.tableFooterView.alpha = isTypingText ? 1.f : 0.f;
    } completion:^(BOOL finished) {
        if (isTypingText) {
            [_pointsActivityIndicatoreView playAnimation];
        } else {
            [_pointsActivityIndicatoreView stopAnimation];
        }
    }];
}

- (void)refresh {
    [_tableView reloadData];
}

#pragma mark - Overriding properties

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _messages = [NSMutableArray new];
    [_roundedView cornerRadius:16.f];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 0.f, 168.f)];
    _tableView.tableFooterView = _tableFooterView;
    _tableView.tableFooterView.alpha = 0.f;
    [_tableView registerCellClass:[OwnerMessageTableViewCell class]];
}

#pragma mark - UITableViewDataSource, TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messages.count;
}

- (UITableViewCell *)tableView:(TableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OwnerMessageTableViewCell *cell = [tableView dequeueReusableCellWithIndex:0];
    Message *message = _messages[indexPath.row];
    cell.message = message.message;
    cell.date = message.date;
    cell.isDelivered = message.isDelivered;
    return cell;
}

#pragma mark - Other methods

#pragma mark - Actions

@end
