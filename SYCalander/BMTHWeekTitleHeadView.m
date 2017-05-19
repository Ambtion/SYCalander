//
//  BMTHWeekTitleHeadView.m
//  basicmap
//
//  Created by quke on 2016/11/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BMTHWeekTitleHeadView.h"


@implementation BMTHWeekTitleHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    CGFloat left = 9.f;
    CGFloat itemWidth = ([[UIScreen mainScreen] bounds].size.width - left - left)/7;
    CGFloat positionLeft = left - itemWidth;
    NSArray *weekTitle = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    for (int i = 0; i < 7; i++) {
        positionLeft += itemWidth;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(positionLeft, 0, itemWidth, self.height)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:RGBA(0x33, 0x33, 0x33, 1)];
        [lab setText:[weekTitle objectAtIndex:i]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [lab setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:lab];
    }
}
@end
