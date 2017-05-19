//
//  BMTHCalenderTool.h
//
//  Created by Linjunhou on 2016/11/21.
//

#import <Foundation/Foundation.h>

@interface BMTHCalenderTool : NSObject

/*
 * 当前日期是星期几
 */
+ (NSInteger)getWeekInCurdate;

/*
 * 某月的第一天是星期几
 */
+ (NSInteger)getWeekOfFirstDayOfyear:(NSInteger)year withMonth:(NSInteger)month;


/*
 * 某月总共天数
 */
+ (NSInteger)totalDaysOfMonthInYear:(NSInteger)year Month:(NSInteger)month;


/*
 * 给定日期是星期几
 */
+ (NSInteger)getWeekDayIndate:(NSDate *)date;

/*
 * 判断两个日期是否是同一天
 */
+ (BOOL)oriDate:(NSDate *)oriDate theSameDayToDesDate:(NSDate *)desDate;



@end
