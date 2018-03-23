//
//  SlidingView.m
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SlidingView.h"


@interface SlidingView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *slidingView;
@property (weak, nonatomic) IBOutlet UIView *slidingContentView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (weak, nonatomic) IBOutlet UIImageView *sliderImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLC;

@end


@implementation SlidingView

#pragma mark - Class properties

- (void)setIsOpen:(BOOL)isOpen {
    [self setIsOpen:isOpen animated:YES];
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
    _isOpen = isOpen;
    CGPoint point = CGPointMake(0.f, _isOpen ? _topBorder : _bottomBorder);
    if (animated) {
        [self interfaceWithPercent:.08f]; // Random float between 0.f and 1.f;
        [UIView animateWithDuration:.48f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _scrollView.contentOffset = point;
        } completion:^(BOOL finished) {
            [self interfaceWithPercent:_isOpen ? 1.f : 0.f];
            if (completion) {
                completion();
            }
        }];
    } else {
        _scrollView.contentOffset = point;
        [self interfaceWithPercent:_isOpen ? 1.f : 0.f];
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
    _scrollView.decelerationRate = .16f;
    [_leftView cornerRadius:4.f];
    [_rightView cornerRadius:4.f];
    [self configureWithUnhideHeight:0.f];
    [self setIsOpen:NO animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat percent = (ABS(_bottomBorder) - ABS(offsetY)) / (ABS(_bottomBorder) - ABS(_topBorder));
    CGFloat margin = _leftLC.constant;
    _leftView.transform = CGAffineTransformMakeTranslation(percent * -margin, 0.f);
    _rightView.transform = CGAffineTransformMakeTranslation(percent * margin, 0.f);
    [self interfaceWithPercent:percent == 0.f || percent == 1.f ? percent : .08f]; // Or random float between 0.f and 1.f;
    if (scrollView.decelerating) {
        [self positionWithOffsetY:offsetY];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self positionWithOffsetY:scrollView.contentOffset.y];
    }
}

#pragma mark - Other methods

- (void)positionWithOffsetY:(CGFloat)offsetY {
    CGFloat border = _isOpen ? _topBorder - _deltaBorder : _bottomBorder + _deltaBorder;
    [self setIsOpen:offsetY >= border animated:YES];
}

@end
