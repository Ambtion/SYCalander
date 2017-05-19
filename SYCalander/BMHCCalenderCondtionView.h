//
//  BMHCCalenderCondtionView.h
//  basicmap
//
//  Created by quke on 2016/11/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMTHCalenderModel.h"

@class BMHCCalenderCondtionView;

@protocol BMHCCalenderCondtionViewDateSource <NSObject>

- (BOOL)hcCalenderConditionView:(BMHCCalenderCondtionView *)pickerView hasTripWhenInDate:(BMTHCalenderModel *)model;
- (BOOL)hcCalenderConditionView:(BMHCCalenderCondtionView *)pickerView hasForceTodayWhenInDate:(BMTHCalenderModel *)model;

@end

@protocol BMHCCalenderCondtionViewDelegate <NSObject>

- (void)hccalenderCondtionView:(BMHCCalenderCondtionView *)calenderCondtionView DidSeltedTime:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


@end

@interface BMHCCalenderCondtionView : UIView

@property(nonatomic,weak)id<BMHCCalenderCondtionViewDelegate> delegate;
@property(nonatomic,weak)id<BMHCCalenderCondtionViewDateSource>dateSource;
@property(nonatomic,strong)NSCalendar * commonCalendar;

- (void)seletedContentDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end


@interface BMHCCalenderCondtionView(EqualMetod)
- (BOOL)date:(NSDate *)date isEqutalYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
@end
