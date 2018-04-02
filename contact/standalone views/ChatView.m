//
//  ChatView.m
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ChatView.h"

#import "VPPointsActivityIndicatorView.h"

#import "MBAutoGrowingTextView.h"

#import "OwnerMessageTableViewCell.h"
#import "ReceiverMessageTableViewCell.h"

#import "ScreenModeManager.h"


@interface ChatView () <UITableViewDataSource, UIScrollViewDelegate> {
    BOOL isKeyboardShow, isDragging;
    CGFloat keyboardHeight;
}

@property (weak, nonatomic) IBOutlet TableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *tableFooterView;

@property (weak, nonatomic) IBOutlet UIView *roundedView; // Receiver typing;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIView *sendView;
@property (weak, nonatomic) IBOutlet UIView *textViewContainerView;

@property (weak, nonatomic) IBOutlet MBAutoGrowingTextView *textView;

@property (weak, nonatomic) IBOutlet VPPointsActivityIndicatorView *pointsActivityIndicatoreView;

@property (strong, nonatomic) UILabel *label;

@end


@implementation ChatView

#pragma mark - Class properties

- (void)setMessages:(NSMutableArray<Message *> *)messages {
    _messages = messages;
    [self reloadData];
}

- (CGSize)headerSize {
    return _tableView.tableHeaderView.frame.size;
}

- (CGSize)footerSize {
    return _tableView.tableFooterView.frame.size;
}

- (void)setIsReceiverTypingText:(BOOL)isReceiverTypingText {
    // TODO:
}

#pragma mark - Class methods

- (void)addMessage:(Message *)message {
    [_messages addObject:message];
    NSUInteger index = [_messages indexOfObject:message];
    [_tableView updatesCompletion:^{
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }];
    [self scrollToBottom];
}

- (void)removeMessageAtIndex:(NSUInteger)index {
    [_messages removeObjectAtIndex:index];
    [_tableView updatesCompletion:^{
        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration {
    keyboardHeight = height;
    [UIView animate:^{
        _editView.transform = CGAffineTransformMakeTranslation(0.f, -keyboardHeight);
        [self configureBottomInset];
    } completion:^{
        isKeyboardShow = show;
    } duration:duration];
}

- (void)reloadData {
    [_tableView reloadData];
}

- (void)scrollToTop {
    _tableView.contentOffset = CGPointZero;
}

- (void)scrollToBottom {
    CGPoint point = CGPointMake(0.f, _tableView.contentSize.height - _tableView.bounds.size.height + _tableView.contentInset.bottom);
    [_tableView setContentOffset:point animated:YES];
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _messages = [NSMutableArray new];
    [_roundedView cornerRadius:.5f * _roundedView.frame.size.height];
    _textView.textContainerInset = UIEdgeInsetsZero;
    _textView.textContainer.lineFragmentPadding = 0.f;
    [_textView sizeToFit];
    _textView.keyboardAppearance = [ScreenModeManager shared].isScreenModeDay ? UIKeyboardAppearanceDefault : UIKeyboardAppearanceDark;
    _textView.didChangeConstraint = ^{
        [self configureBottomInset];
    };
    _tableView.refreshControl = nil;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 0.f, 198.f)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 0.f, 4.f)];
    [_tableView registerCellClass:[OwnerMessageTableViewCell class]];
    [_tableView registerCellClass:[ReceiverMessageTableViewCell class]];
    [_textViewContainerView cornerRadius:.5f * _textViewContainerView.frame.size.height];
    [_textViewContainerView borderWithColor:[[UIColor blackColor] colorWithAlphaComponent:.16f]];
    [self configureBottomInset];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendView_TUI)];
    [_sendView addGestureRecognizer:tapGR];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

#pragma mark - UITableViewDataSource, TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messages.count;
}

- (UITableViewCell *)tableView:(TableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = [self messageWithIndexPath:indexPath];
    OwnerMessageTableViewCell *cell = [tableView dequeueReusableCellWithIndex:message.isOwner ? 0 : 1];
    cell.message = message.text;
    cell.date = message.date;
    cell.isDelivered = message.isDelivered;
    cell.neededNightMode = !message.isOwner;
    cell.isNightMode = [ScreenModeManager shared].isScreenModeNight;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont fontWithName:@"OpenSans-Regular" size:14.f];
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
    }
    Message *message = [self messageWithIndexPath:indexPath];
    _label.text = message.text;
    [_label sizeToFit];
    CGSize size = [_label sizeThatFits:CGSizeMake(.68f * WIDTH - 32.f, FLT_MAX)];
    size.height += 36.f; // One pixel is separator;
    return size.height;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        if ([_delegate respondsToSelector:@selector(chatView:didScrollWithPoint:)]) {
            [_delegate chatView:self didScrollWithPoint:scrollView.contentOffset];
        }
        if (isKeyboardShow && isDragging) {
            CGPoint point = [scrollView.panGestureRecognizer locationInView:self];
            BOOL condition = point.y >= HEIGHT - keyboardHeight;
            CGFloat y = condition ? point.y - HEIGHT : -keyboardHeight;
            _editView.transform = CGAffineTransformMakeTranslation(0.f, y);
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        isDragging = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == _tableView) {
        isDragging = NO;
    }
}

#pragma mark - Other methods

- (void)configureBottomInset {
    _tableView.contentInset = UIEdgeInsetsMake(0.f, 0.f, _editView.frame.size.height + keyboardHeight - 8.f, 0.f);
}

- (void)applicationWillEnterForeground {
    if (isKeyboardShow) {
        [_textView becomeFirstResponder];
    }
}

- (Message *)messageWithIndexPath:(NSIndexPath *)indexPath {
    Message *message;
    if (_messages.count > 0 && _messages.count - 1 >= indexPath.row) {
        message = _messages[indexPath.row];
    }
    return message;
}

#pragma mark - Actions

- (void)sendView_TUI {
    if (_textView.text.length == 0) {
        return;
    }
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"hh:mm";
    NSString *stringDate = [dateFormatter stringFromDate:[NSDate date]];
    Message *message = [Message new];
    message.text = _textView.text;
    message.date = stringDate;
    message.isOwner = YES;
    message.isDelivered = NO;
    [self addMessage:message];
    _textView.text = [NSString new];
    if ([_delegate respondsToSelector:@selector(chatView:didSendMessage:)]) {
        [_delegate chatView:self didSendMessage:message];
    }
}

@end
