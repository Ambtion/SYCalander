//
//  BMHCCalenderTabView.h
//  basicmap
//
//  Created by quke on 2016/11/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMTHCalenderModel.h"

@class BMHCCalenderTabView;

@protocol BMHCCalenderTabViewDataSource <NSObject>

- (BOOL)hcCanlenderTabView:(BMHCCalenderTabView *)tabView  didHasTripWhenInDate:(BMTHCalenderModel *)model;
- (BOOL)hcCanlenderTabView:(BMHCCalenderTabView *)tabView  didSeletedWhenInDate:(BMTHCalenderModel *)model;
- (BOOL)hcCanlenderTabView:(BMHCCalenderTabView *)tabView hasForceTodayWhenInDate:(BMTHCalenderModel *)model;

@end

@protocol BMHCCalenderTabViewDelegate <NSObject>

- (void)hcCalenderPickerView:(id)pickerView didSeletedDate:(BMTHCalenderModel *)model;

@end

@interface BMHCCalenderTabView : UIView

@property(nonatomic,weak)id<BMHCCalenderTabViewDataSource>dataSourceDelegate;
@property(nonatomic,weak)id<BMHCCalenderTabViewDelegate> delegate;

- (void)seletedContentDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


@end
