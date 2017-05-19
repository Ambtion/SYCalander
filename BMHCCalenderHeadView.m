//
//  BMHCCalenderHeadView.m
//  basicmap
//
//  Created by quke on 2016/11/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BMHCCalenderHeadView.h"

#define WEEK_HEIGHT     21.0f
#define WEEK_WIDTH      40.0f

@interface BMHCCalenderHeadView()

@end

@implementation BMHCCalenderHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = UIColorFromRGB(0xffffff);

    }
    return self;
}

- (void)initUI
{
    
    UILabel * firstLabel = nil;
    UILabel * lastLabel = nil;
    CGFloat left = 9.f;
    CGFloat itemWidth = (IPHONE_SCREEN_WIDTH - left - left)/7;
    CGFloat positionLeft = left - itemWidth;
    NSArray *weekTitle = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    for (int i = 0; i < 7; i++) {
        positionLeft += itemWidth;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(positionLeft, 0, itemWidth, 12.f)];
        lab.bottom = self.height - 5.f;
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:RGBA(0x33, 0x33, 0x33, 1)];
        [lab setText:[weekTitle objectAtIndex:i]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [lab setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:lab];
        
        if (i == 0) {
            firstLabel = lab;
        }
        
        if (i == 6) {
            lastLabel = lab;
        }
    }

    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColorFromRGB(0x333333);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    [self addSubview:self.titleLabel];

    
    UIButton *preButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [preButton setImage:[UIImage imageNamed:@"pre_day_normal"] forState:UIControlStateNormal];
//    [preButton setImage:[UIImage imageNamed:@"pre_day_press"] forState:UIControlStateHighlighted];
    [preButton addTarget:self action:@selector(onPrevious:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:preButton];
    
    UIButton *nexButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nexButton setImage:[UIImage imageNamed:@"next_day_normal"] forState:UIControlStateNormal];
//    [nexButton setImage:[UIImage imageNamed:@"next_day_press"] forState:UIControlStateHighlighted];
    [nexButton addTarget:self action:@selector(onNext:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nexButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(7.f);
        make.centerX.equalTo(self);
    }];
    
    [preButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        if (firstLabel) {
            make.centerX.equalTo(firstLabel);
        }
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [nexButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        if (lastLabel) {
            make.centerX.equalTo(lastLabel);
        }
        make.size.equalTo(preButton);
    }];
}

- (void)onPrevious:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onPreviousClick:)]) {
        [self.delegate performSelector:@selector(onPreviousClick:) withObject:sender];
    }
    
    [BMStatisticsTool addActionLog:@"TripHelperListPG.calendarMonth"];
}

- (void)onNext:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onNextClick:)]) {
        [self.delegate performSelector:@selector(onNextClick:) withObject:sender];
    }
    
    [BMStatisticsTool addActionLog:@"TripHelperListPG.calendarMonth"];
}



@end

