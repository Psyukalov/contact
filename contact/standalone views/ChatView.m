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
#import "ReceiverMessageTableViewCell.h"

#import "ScreenModeManager.h"


@interface ChatView () <UITableViewDataSource, UIScrollViewDelegate> {
    CGFloat keyboardHeight;
    BOOL isKeyboardOpen;
}

@property (weak, nonatomic) IBOutlet TableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *tableFooterView;

@property (weak, nonatomic) IBOutlet UIView *roundedView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIView *sendView;
@property (weak, nonatomic) IBOutlet UIView *textViewContainerView;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet VPPointsActivityIndicatorView *pointsActivityIndicatoreView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editViewHeightLC;

@end


@implementation ChatView

#pragma mark - Class properties

- (void)setMessages:(NSMutableArray<Message *> *)messages {
    _messages = messages;
    [self refresh];
}

- (CGSize)headerSize {
    return _tableView.tableHeaderView.frame.size;
}

- (CGSize)footerSize {
    return _tableView.tableFooterView.frame.size;
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

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration {
    keyboardHeight = height;
    [UIView animate:^{
        _editView.transform = CGAffineTransformMakeTranslation(0.f, -height);
        [self configureBottomInset];
    } completion:^{
        isKeyboardOpen = show;
    } duration:duration];
}

- (void)refresh {
    [_tableView reloadData];
}

#pragma mark - Overriding properties

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _tableView.refreshControl = nil;
    _textView.keyboardAppearance = [ScreenModeManager shared].isScreenModeDay ? UIKeyboardAppearanceDefault : UIKeyboardAppearanceDark;
    _messages = [NSMutableArray new];
    [_roundedView cornerRadius:16.f];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 0.f, 198.f)];
    _tableView.tableFooterView = _tableFooterView;
    _tableView.tableFooterView.alpha = 0.f;
    [_tableView registerCellClass:[OwnerMessageTableViewCell class]];
    [_tableView registerCellClass:[ReceiverMessageTableViewCell class]];
    [_textViewContainerView cornerRadius:16.f];
    [_textViewContainerView borderWithColor:[[UIColor blackColor] colorWithAlphaComponent:.16f]];
    [self configureBottomInset];
}

#pragma mark - UITableViewDataSource, TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messages.count;
}

- (UITableViewCell *)tableView:(TableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = _messages[indexPath.row];
    OwnerMessageTableViewCell *cell = [tableView dequeueReusableCellWithIndex:message.isOwner ? 0 : 1];
    cell.message = message.message;
    cell.date = message.date;
    cell.isDelivered = message.isDelivered;
    cell.neededNightMode = !message.isOwner;
    cell.isNightMode = [ScreenModeManager shared].isScreenModeNight;
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(chatView:didScrollWithPoint:)]) {
        [_delegate chatView:self didScrollWithPoint:scrollView.contentOffset];
    }
    if (isKeyboardOpen) {
        CGPoint point = [scrollView.panGestureRecognizer locationInView:self];
        BOOL condition = point.y >= HEIGHT - keyboardHeight;
        CGFloat y = condition ? point.y - HEIGHT : -keyboardHeight;
        _editView.transform = CGAffineTransformMakeTranslation(0.f, y);
    }
}

#pragma mark - Other methods

- (void)configureBottomInset {
    _tableView.contentInset = UIEdgeInsetsMake(0.f, 0.f, _editView.frame.size.height + keyboardHeight, 0.f);
}

#pragma mark - Actions

@end
