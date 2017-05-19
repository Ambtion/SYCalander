//
//  SYViewController.m
//  SYCalander
//
//  Created by quke on 05/18/2017.
//  Copyright (c) 2017 quke. All rights reserved.
//

#import "SYViewController.h"
#import "BMHCCalenderCondtionView.h"

@interface SYViewController ()<BMHCCalenderCondtionViewDelegate,BMHCCalenderCondtionViewDateSource>

@property(nonatomic,strong)BMHCCalenderCondtionView * dateConditonView;

@end

@implementation SYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.dateConditonView = [[BMHCCalenderCondtionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.dateConditonView.delegate = self;
    self.dateConditonView.dateSource = self;
    [self.view addSubview:self.dateConditonView];
    [self seltedContionViewTodate:[NSDate date]];
}

- (void)seltedContionViewTodate:(NSDate *)date
{
    NSDateComponents *dateComp = [self.dateConditonView.commonCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    [self.dateConditonView seletedContentDateWithYear:dateComp.year month:dateComp.month day:dateComp.day];
}

- (BOOL)hcCalenderConditionView:(BMHCCalenderCondtionView *)pickerView hasTripWhenInDate:(BMTHCalenderModel *)model
{
    return YES;
}

- (BOOL)hcCalenderConditionView:(BMHCCalenderCondtionView *)pickerView hasForceTodayWhenInDate:(BMTHCalenderModel *)model
{
    return NO;
}

- (void)hccalenderCondtionView:(BMHCCalenderCondtionView *)calenderCondtionView DidSeltedTime:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    
}


@end
