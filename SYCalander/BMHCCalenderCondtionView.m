//
//  BMHCCalenderCondtionView.m
//  basicmap
//
//  Created by quke on 2016/11/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BMHCCalenderCondtionView.h"
#import "BMHCCalenderTabView.h"
#import "BMHCCalenderPickerView.h"


@interface BMHCCalenderCondtionView()<BMHCCalenderPickerViewDelegate,BMHCCalenderPickerViewDateSource,BMHCCalenderTabViewDataSource,BMHCCalenderTabViewDelegate>

@property(nonatomic,strong) BMHCCalenderTabView * tabView;
@property(nonatomic,strong) BMHCCalenderPickerView * pickerView;
@property(nonatomic,strong) UIImageView * expandView;
@property(nonatomic,strong) UIView * shadowView;

@property(nonatomic,assign) NSInteger seletedYear;
@property(nonatomic,assign) NSInteger seletedMonth;
@property(nonatomic,assign) NSInteger seletedDay;

@end

@implementation BMHCCalenderCondtionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self initTabView];
}


- (void)initTabView
{
    self.tabView = [[BMHCCalenderTabView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.tabView.dataSourceDelegate  = self;
    self.tabView.delegate = self;
    self.tabView.clipsToBounds = NO;
    [self addSubview:self.tabView];
    [self initExpandView];
}

- (void)initExpandView
{
    self.expandView = [[UIImageView alloc] init];
    self.expandView.image = [UIImage imageNamed:@"expand_normal"];
    [self.expandView setUserInteractionEnabled:YES];
    [self.tabView addSubview:self.expandView];
    
    [self.expandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tabView.mas_bottom).offset(-1);
        make.centerX.equalTo(self);
    }];    
    
    UIView * tapView = [[UIView alloc] init];
    tapView.backgroundColor = [UIColor clearColor];
    [self.tabView addSubview:tapView];
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.expandView);
        make.width.equalTo(@(60));
        make.bottom.equalTo(self.expandView);
        make.height.equalTo(@(30));
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(arrowImageViewDidTap:)];
    [tapView addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer * swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(arrowImageViewDidTap:)];
    swipGes.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipGes];
}

#pragma mark - Expand or Close Amimation
- (void)arrowImageViewDidTap:(UITapGestureRecognizer *)tap
{
    if (!self.pickerView) {
        
        self.pickerView = [[BMHCCalenderPickerView alloc] initWithFrame:CGRectMake(0, 0, self.width, 340)];
        self.pickerView.bottom = self.top;
        self.pickerView.delegate = self;
        self.pickerView.dataSourceDelegate = self;
        
        [self.superview insertSubview:self.pickerView belowSubview:self];
        
        
        UIImageView * closeView = [[UIImageView alloc] init];
        closeView.image = [UIImage imageNamed:@"expand_normal"];
        [self.pickerView addSubview:closeView];

        [closeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(23, 10));
            make.bottom.equalTo(self.pickerView).offset(-3);
            make.centerX.equalTo(self.pickerView);
        }];
        
        UIView * tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [self.pickerView addSubview:tapView];
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(closeView);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAnyConditionView:)];
        [tapView addGestureRecognizer:tap];
        
        UISwipeGestureRecognizer * swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeAnyConditionView:)];
        swipGes.direction = UISwipeGestureRecognizerDirectionUp;
        [tapView addGestureRecognizer:swipGes];
        [self.pickerView addGestureRecognizer:swipGes];


    }
    
    if (!_shadowView) {
        _shadowView = [[UIView alloc]initWithFrame:CGRectZero];
        [_shadowView setBackgroundColor:RGBA(0.0f, 0.0f, 0.0f, 1)];
        [_shadowView setAlpha:0.0f];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAnyConditionView:)];
        [_shadowView addGestureRecognizer:recognizer];
        
        [self.superview insertSubview:self.shadowView belowSubview:self.pickerView];
        
        UISwipeGestureRecognizer * swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeAnyConditionView:)];
        swipGes.direction = UISwipeGestureRecognizerDirectionUp;
        [_shadowView addGestureRecognizer:swipGes];
    }
    
    [self showPickerView];

}

- (void)showPickerView
{
    [self.pickerView seletedContentDateWithYear:self.seletedYear month:self.seletedMonth day:self.seletedDay];
    
    _shadowView.frame = CGRectMake(0, -15, self.width, self.superview.height + 15);
    [self.expandView setHidden:YES];
    [self anitamtions:^{
        self.pickerView.top = self.top;
        self.tabView.bottom = 0;
        [self setUserInteractionEnabled:NO];
        [_shadowView setAlpha:0.45f];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)closeAnyConditionView:(UITapGestureRecognizer *)tap
{
    
    [self.expandView setHidden:NO];
    [self anitamtions:^{
        [_shadowView setAlpha:0.0f];
        self.tabView.top = 0;
        [self setUserInteractionEnabled:YES];
        self.pickerView.bottom = self.top;
    } completion:^(BOOL finished) {
        [_shadowView setFrame:CGRectZero];
    }];
}

- (void)anitamtions:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    
    [UIView animateWithDuration:0.3 animations:animations completion:^(BOOL finished) {
        if (completion)
            completion(finished);
    }];
}


#pragma mark - Public Method
- (void)seletedContentDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    self.seletedYear = year;
    self.seletedMonth = month;
    self.seletedDay = day;
    [self.tabView seletedContentDateWithYear:year month:month day:day];
    [self.pickerView seletedContentDateWithYear:year month:month day:day];
}


#pragma mark - delegate
- (void)hcCalenderPickerView:(BMHCCalenderPickerView *)pickerView didSeletedDate:(BMTHCalenderModel *)model
{
    self.seletedYear = model.year;
    self.seletedMonth = model.month;
    self.seletedDay = model.day;
    
    [self.tabView seletedContentDateWithYear:self.seletedYear month:self.seletedMonth day:self.seletedDay];
    [self closeAnyConditionView:nil];
    
    if ([_delegate respondsToSelector:@selector(hccalenderCondtionView:DidSeltedTime:month:day:)]) {
        [_delegate hccalenderCondtionView:self DidSeltedTime:model.year month:model.month day:model.day];
    }
}

#pragma mark - dataSoure
- (BOOL)hcCalenderPickerView:(BMHCCalenderPickerView *)pickerView didHasTripWhenInDate:(BMTHCalenderModel *)model
{
    if([_dateSource respondsToSelector:@selector(hcCalenderConditionView:hasTripWhenInDate:)]){
        return [_dateSource hcCalenderConditionView:self hasTripWhenInDate:model];
    }
    return NO;
}

- (BOOL)hcCanlenderTabView:(BMHCCalenderTabView *)tabView hasForceTodayWhenInDate:(BMTHCalenderModel *)model
{
    if ([_dateSource respondsToSelector:@selector(hcCalenderConditionView:hasForceTodayWhenInDate:)]) {
        return [_dateSource hcCalenderConditionView:self hasForceTodayWhenInDate:model];
    }
    return NO;
}

- (BOOL)hcCalenderPickerView:(BMHCCalenderPickerView *)pickerView hasForceTodayWhenInDate:(BMTHCalenderModel *)model
{
    if ([_dateSource respondsToSelector:@selector(hcCalenderConditionView:hasForceTodayWhenInDate:)]) {
        return [_dateSource hcCalenderConditionView:self hasForceTodayWhenInDate:model];
    }
    return NO;
}

- (BOOL)hcCanlenderTabView:(BMHCCalenderTabView *)tabView didHasTripWhenInDate:(BMTHCalenderModel *)model
{
    if([_dateSource respondsToSelector:@selector(hcCalenderConditionView:hasTripWhenInDate:)]){
        return [_dateSource hcCalenderConditionView:self hasTripWhenInDate:model];
    }
    return NO;
}

#pragma mark - Seleted
- (BOOL)hcCanlenderTabView:(BMHCCalenderTabView *)tabView didSeletedWhenInDate:(BMTHCalenderModel *)model
{
    return (model.year == self.seletedYear) && (model.month == self.seletedMonth) && (model.day == self.seletedDay);
}

- (BOOL)hcCalenderPickerView:(BMHCCalenderPickerView *)pickerView didSeltedWhenInDate:(BMTHCalenderModel *)model
{
    return (model.year == self.seletedYear) && (model.month == self.seletedMonth) && (model.day == self.seletedDay);
}

- (NSCalendar *)commonCalendar
{
    if (!_commonCalendar) {
        _commonCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _commonCalendar;
}

@end


@implementation BMHCCalenderCondtionView(EqualMetod)

- (BOOL)date:(NSDate *)date isEqutalYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateComponents *dateComp = [self.commonCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    return (dateComp.year == year) && (dateComp.month == month) && (dateComp.day == day);
}

@end
