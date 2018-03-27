//
//  SlidingView.m
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SlidingView.h"


@interface SlidingView () {
    BOOL neededOffsetY;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *slidingView;
@property (weak, nonatomic) IBOutlet UIView *slidingContentView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (weak, nonatomic) IBOutlet UIImageView *sliderImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLC;

@property (assign, nonatomic) CGFloat percent;

@end


@implementation SlidingView

#pragma mark - Class properties

- (void)setIsOpen:(BOOL)isOpen {
    [self setIsOpen:isOpen animated:YES];
}

- (void)setIsScrollEnabled:(BOOL)isScrollEnabled {
    [super setIsScrollEnabled:isScrollEnabled];
    _scrollView.scrollEnabled = self.isScrollEnabled;
}

#pragma mark - Class methods

- (void)configureWithUnhideHeight:(CGFloat)unhideHeight {
    _scrollView.contentInset = UIEdgeInsetsMake(HEIGHT - unhideHeight - 18.f, 0.f, 0.f, 0.f);
    _topBorder = -(HEIGHT - _slidingView.frame.size.height);
    _bottomBorder = -_scrollView.contentInset.top;
}

- (void)setIsOpen:(BOOL)isOpen animated:(BOOL)animated {
    [self setIsOpen:isOpen animated:animated completion:nil];
}

- (void)setIsOpen:(BOOL)isOpen animated:(BOOL)animated completion:(void (^)(void))completion {
    neededOffsetY = NO;
    _isOpen = isOpen;
    CGPoint point = CGPointMake(0.f, _isOpen ? _topBorder : _bottomBorder);
    if (animated) {
        [self interfaceWithPercent:.08f]; // Random float between 0.f and 1.f;
        [UIView animateWithDuration:.48f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _scrollView.contentOffset = point;
        } completion:^(BOOL finished) {
            [self viewsWithPercent:_isOpen ? 1.f : 0.f];
            [self interfaceWithPercent:_isOpen ? 1.f : 0.f];
            neededOffsetY = YES;
            if (completion) {
                completion();
            }
        }];
    } else {
        _scrollView.contentOffset = point;
        [self viewsWithPercent:_isOpen ? 1.f : 0.f];
        [self interfaceWithPercent:_isOpen ? 1.f : 0.f];
        neededOffsetY = YES;
        if (completion) {
            completion();
        }
    }
}

- (void)interfaceWithPercent:(CGFloat)percent {
    NSLog(@"Interface with percent: %1.2f;", percent);
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [self layoutIfNeeded];
    neededOffsetY = YES;
    _scrollView.decelerationRate = .16f;
    [_leftView cornerRadius:4.f];
    [_rightView cornerRadius:4.f];
    [self configureWithUnhideHeight:0.f];
    [self setIsOpen:NO animated:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        _percent = (ABS(_bottomBorder) - ABS(offsetY)) / (ABS(_bottomBorder) - ABS(_topBorder));
        if (_percent < 0.f) {
            _percent = 0.f;
        }
        if (_percent > 1.f) {
            _percent = 1.f;
        }
        [self viewsWithPercent:_percent];
        if (neededOffsetY) {
            [self interfaceWithPercent:_percent == 0.f || _percent == 1.f ? _percent : .08f]; // Or random float between 0.f and 1.f;
        }
        if (scrollView.decelerating) {
            [self positionWithOffsetY:offsetY];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == _scrollView && !decelerate && (_percent > 0.f && _percent < 1.f)) {
        [self positionWithOffsetY:scrollView.contentOffset.y];
    }
}

#pragma mark - Other methods

- (void)positionWithOffsetY:(CGFloat)offsetY {
    CGFloat border = _isOpen ? _topBorder - _deltaBorder : _bottomBorder + _deltaBorder;
    [self setIsOpen:offsetY >= border animated:YES];
}

- (void)viewsWithPercent:(CGFloat)percent {
    CGFloat margin = _leftLC.constant;
    _leftView.transform = CGAffineTransformMakeTranslation(percent * -margin, 0.f);
    _rightView.transform = CGAffineTransformMakeTranslation(percent * margin, 0.f);
}

@end
