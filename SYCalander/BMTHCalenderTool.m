//
//  BMCalenderTool.m
//  basicmap
//
//  Created by quke on 2016/11/18.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BMTHCalenderTool.h"

@implementation BMTHCalenderTool

/*
 * 判断两个日期是否是同一天
 */
+ (BOOL)oriDate:(NSDate *)oriDate theSameDayToDesDate:(NSDate *)desDate
{
    //日历时间
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *oriComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:oriDate];
    NSDateComponents *desComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:desDate];

    return  (oriComp.year == desComp.year) && (oriComp.month == desComp.month) && (oriComp.day == desComp.day);
}

#pragma mark - Week

/*
 * 当前日期是星期几
 */
+ (NSInteger)getWeekInCurdate
{
    return [self getWeekDayIndate:[NSDate date]];
}

/*
 * 某月的第一天是星期几
 */
+ (NSInteger)getWeekOfFirstDayOfyear:(NSInteger)year withMonth:(NSInteger)month
{
    return [self getWeekOfFirstDayOfyear:year withMonth:month day:1];
}


+ (NSInteger)getWeekOfFirstDayOfyear:(NSInteger)year withMonth:(NSInteger)month day:(NSInteger)day
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", (long)year,(long)month,(long)day];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return [self getWeekDayIndate:date];
}

/*
 * 给定日期是星期几
 */
+ (NSInteger)getWeekDayIndate:(NSDate *)date
{
    //日历时间
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    
    //周日 = 1，周一 = 2，依次类推
    return  [dateComp weekday] - 1;
}


/*
 * 某月总共天数
 */
+ (NSInteger)totalDaysOfMonthInYear:(NSInteger)year Month:(NSInteger)month{
    
    
    NSInteger mouthTotalDay = 30;
    
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
        {
            mouthTotalDay = 31;
        }
        
            break;
        case 2:
        {
            //闰年二月
            month = [self isLoopYear:year] ? 28 : 29;
        }
            break;
        case 4:
        case 6:
        case 9:
        case 11:
        {
            mouthTotalDay = 30;
        }
        default:
            break;
    }
    return mouthTotalDay;
}


/*
 *  是否是闰年
 */
+ (BOOL)isLoopYear:(NSInteger)year{
    
    //①：非整百年数除以4，无余为闰，有余为平；②整百年数除以400，无余为闰有余平
    return (year % 100 != 0 && year % 4 == 0) || year % 400 == 0;
}


@end
