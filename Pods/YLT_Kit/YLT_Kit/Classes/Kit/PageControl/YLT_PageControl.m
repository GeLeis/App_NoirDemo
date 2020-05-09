//
//  YLT_PageControl.m
//  App
//
//  Created by 項普華 on 2019/12/19.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "YLT_PageControl.h"

@interface YLT_PageControl ()
/**  */
@property (nonatomic, strong) NSMutableArray<UIView *> *dots;
/** <#注释#> */
@property (nonatomic, strong) UIView *contentView;
/** <#注释#> */
@property (nonatomic, strong) UIView *currentDot;

@end

@implementation YLT_PageControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.dots = [[NSMutableArray alloc] init];
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = UIColor.clearColor;
        [self addSubview:self.contentView];
        
    }
    return self;
}

- (void)setTotalPageCount:(NSInteger)totalPageCount {
    if (totalPageCount == 0) {
        self.hidden = YES;
        return;
    }
    self.hidden = NO;
    _totalPageCount = totalPageCount;
    [self.dots removeAllObjects];
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat x = self.spacing+self.normalDotSize.width/2.;
    for (NSInteger i = 0; i < totalPageCount; i++) {
        UIView *dot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.normalDotSize.width, self.normalDotSize.height)];
        dot.backgroundColor = self.normalColor;
        dot.tag = 100+i;
        [self.contentView addSubview:dot];
        dot.ylt_tap(self, @selector(tapDot:));
        [dot ylt_enlargeEdgeWithTop:10 left:self.spacing/2. bottom:10. right:self.spacing/2.];
        [dot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_left).offset(x);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(self.normalDotSize);
        }];
        x += (self.spacing+self.normalDotSize.width);
        [dot ylt_cornerType:UIRectCornerAllCorners radius:self.normalDotSize.height/2.];

        [self.dots addObject:dot];
    }
    
    CGFloat width = self.spacing*(totalPageCount+1)+self.normalDotSize.width*totalPageCount;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.height.equalTo(self);
        make.width.mas_equalTo(width);
    }];
    self.currentDot = [[UIView alloc] init];
    self.currentDot.backgroundColor = self.currentPageColor;
    [self.contentView addSubview:self.currentDot];
    self.currentDot.layer.cornerRadius = self.currentDotSize.height/2.;
    [self.currentDot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.dots[0]);
        make.size.mas_equalTo(self.currentDotSize);
    }];
    
    [self layoutIfNeeded];
    self.currentPageIndex = 0;
}

- (void)tapDot:(UITapGestureRecognizer *)sender {
    self.currentPageIndex = sender.view.tag-100;
}

#define ANIMATED_DURATION 0.27
- (void)setCurrentPageIndex:(NSInteger)currentPageIndex {
    NSInteger lastPageIndex = _currentPageIndex;
    _currentPageIndex = currentPageIndex%self.totalPageCount;
    if (_currentPageIndex == lastPageIndex) {
        return;
    }
    
    if (_currentPageIndex > lastPageIndex) {
        [self.currentDot mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.dots[_currentPageIndex].mas_right).offset((self.currentDotSize.width-self.normalDotSize.width)/2.);
            make.size.mas_equalTo(CGSizeMake(self.currentDotSize.width*2., self.currentDotSize.height));
        }];
        [UIView animateWithDuration:ANIMATED_DURATION delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.contentView layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    } else {
        [self.currentDot mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.dots[_currentPageIndex].mas_left).offset((self.normalDotSize.width-self.currentDotSize.width)/2.);
            make.size.mas_equalTo(CGSizeMake(self.currentDotSize.width*2., self.currentDotSize.height));
        }];
        [UIView animateWithDuration:ANIMATED_DURATION delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.contentView layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }

    YLT_MAINDelay(ANIMATED_DURATION/2., ^{
        [self.currentDot mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.dots[self.currentPageIndex]);
            make.size.mas_equalTo(self.currentDotSize);
        }];
        [UIView animateWithDuration:ANIMATED_DURATION delay:0. options:UIViewAnimationOptionCurveLinear animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    });
    if (self.currentPageDidChange) {
        self.currentPageDidChange(_currentPageIndex);
    }
}

- (CGFloat)spacing {
    if (_spacing == 0) {
        return 7;
    }
    return _spacing;
}

- (CGSize)currentDotSize {
    if (CGSizeEqualToSize(CGSizeZero, _currentDotSize)) {
        return CGSizeMake(15., 7.);
    }
    return _currentDotSize;
}

- (CGSize)normalDotSize {
    if (CGSizeEqualToSize(CGSizeZero, _normalDotSize)) {
        return CGSizeMake(7., 7.);
    }
    return _normalDotSize;
}

- (UIColor *)currentPageColor {
    if (_currentPageColor == nil) {
        return @"FF7575".ylt_colorFromHexString;
    }
    return _currentPageColor;
}

- (UIColor *)normalColor {
    if (_normalColor == nil) {
        return @"E5E5E5".ylt_colorFromHexString;
    }
    return _normalColor;
}

- (RACSignal *)currentPageSianal {
    return RACObserve(self, currentPageIndex);
}

@end
