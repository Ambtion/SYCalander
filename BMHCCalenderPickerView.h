//
//  BMHCCalenderPickerView.h
//  basicmap
//
//  Created by quke on 2016/11/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMTHCalenderModel.h"

@class BMHCCalenderPickerView;

@protocol BMHCCalenderPickerViewDelegate <NSObject>

- (void)hcCalenderPickerView:(BMHCCalenderPickerView *)pickerView didSeletedDate:(BMTHCalenderModel *)model;

@end

@protocol BMHCCalenderPickerViewDateSource <NSObject>

- (BOOL)hcCalenderPickerView:(BMHCCalenderPickerView *)pickerView didHasTripWhenInDate:(BMTHCalenderModel *)model;
- (BOOL)hcCalenderPickerView:(BMHCCalenderPickerView *)pickerView didSeltedWhenInDate:(BMTHCalenderModel *)model;
- (BOOL)hcCalenderPickerView:(BMHCCalenderPickerView *)pickerView hasForceTodayWhenInDate:(BMTHCalenderModel *)model;

@end

@interface BMHCCalenderPickerView : UIView

@property(nonatomic,weak)id<BMHCCalenderPickerViewDelegate> delegate;
@property(nonatomic,weak)id<BMHCCalenderPickerViewDateSource> dataSourceDelegate;

- (void)seletedContentDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


@end
