//
//  ManualView.m
//  contact
//
//  Created by Vladimir Psyukalov on 21.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ManualView.h"

#import "iCarousel.h"

#import "FirstManualItemView.h"
#import "SecondManualItemView.h"
#import "ThirdManualItemView.h"


#define kTitleLabelRate (1.28f)
#define kDescriptionLabelRate (.64f)


@interface ManualView () <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carouselView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSArray<NSString *> *titles;
@property (strong, nonatomic) NSArray<NSString *> *descriptions;

@end


@implementation ManualView

#pragma mark - Overriding properties

- (void)setParallaxPoint:(CGPoint)parallaxPoint {
    [super setParallaxPoint:parallaxPoint];
    CGFloat x = self.parallaxPoint.x;
    CGFloat y = self.parallaxPoint.y;
    [UIView animate:^{
        _titleLabel.transform = CGAffineTransformMakeTranslation(kTitleLabelRate * x, -kTitleLabelRate * y);
        _descriptionLabel.transform = CGAffineTransformMakeTranslation(kDescriptionLabelRate * x, -kDescriptionLabelRate * y);
    } completion:nil duration:.16f];
    CItemView *itemView = (CItemView *)_carouselView.currentItemView;
    itemView.parallaxPoint = parallaxPoint;
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _titles = @[LOCALIZE(@"mv_title_0"), LOCALIZE(@"mv_title_1"), LOCALIZE(@"mv_title_2")];
    _descriptions = @[LOCALIZE(@"mv_title_3"), LOCALIZE(@"mv_title_4"), LOCALIZE(@"mv_title_5")];
    _carouselView.decelerationRate = .64f;
    _carouselView.bounces = NO;
    [_carouselView reloadData];
    _pageControl.numberOfPages = _titles.count;
    [self updateLabelsWithIndex:0];
}

- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated completion:(void (^)(void))completion {
    [super viewAnimation:viewAnimation animated:animated completion:^{
        [self resetStartAnimationsWithCarousel:_carouselView];
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - iCarouselDataSource, iCarouselDelegate

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _titles.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (!view) {
        switch (index) {
            case 0:
                view = [[FirstManualItemView alloc] initWithFrame:carousel.bounds];
                break;
            case 1:
                view = [[SecondManualItemView alloc] initWithFrame:carousel.bounds];
                break;
            case 2:
                view = [[ThirdManualItemView alloc] initWithFrame:carousel.bounds];
                break;
            default:
                view = [[FirstManualItemView alloc] initWithFrame:carousel.bounds];
                break;
        }
    }
    return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    [self updateLabelsWithIndex:carousel.currentItemIndex];
    [self resetStartAnimationsWithCarousel:carousel];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option) {
        case iCarouselOptionVisibleItems:
            return _titles.count;
            break;
        case iCarouselOptionSpacing:
            return 1.28f * value;
            break;
        default:
            return value;
            break;
    }
}

#pragma mark - Other methods

- (void)updateLabelsWithIndex:(NSUInteger)index {
    _pageControl.currentPage = index;
    [UIView animate:^{
        _titleLabel.alpha = 0.f;
        _descriptionLabel.alpha = 0.f;
        _titleLabel.text = _titles[index];
        _descriptionLabel.text = _descriptions[index];
        _titleLabel.alpha = 1.f;
        _descriptionLabel.alpha = 1.f;
    } completion:nil duration:.64f];
}

- (void)resetStartAnimationsWithCarousel:(iCarousel *)carousel {
    for (CItemView *itemView in carousel.visibleItemViews) {
        if ([itemView isEqual:carousel.currentItemView]) {
            [itemView playAnimation];
        } else {
            [itemView stopAnimation];
        }
    }
}

#pragma mark - Actions

- (IBAction)closeButton_TUI:(UIButton *)sender {
    if (self.didCloseViewCompletion) {
        self.didCloseViewCompletion();
    }
}

@end
