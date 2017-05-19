//
//  BMTripCalenderTool.m
//
//  Created by Linjunhou on 2016/11/21.
//

#import "BMTHTripCalenderTool.h"
#import "BMTHCalenderTool.h"
#import "BMTHCalenderModel.h"

@implementation BMTHTripCalenderTool


#pragma mark - WeekList
+ (NSArray *)getWeekDaysListContaitInYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld", (long)year,(long)month,(long)day];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSInteger weekDay = [BMTHCalenderTool getWeekDayIndate:date];
    
    
    NSMutableArray * weekList = [NSMutableArray arrayWithCapacity:7];
    
    //当前日期前同一周时间补位
    for (NSInteger i = 0; i < weekDay; i ++) {
        
        NSInteger preYear = year;
        NSInteger preMonth = month;
        NSInteger preDay = day - weekDay + i;
        
        if(preDay <= 0){
            
            preDay = [BMTHCalenderTool totalDaysOfMonthInYear:preYear Month:preMonth] + preDay;
            preMonth = month - 1;
            if(preMonth <= 0){
                preMonth = 12;
                preYear = year - 1;
            }
            
        }
        
        id dateModel = [self dateModelWithYear:preYear month:preMonth day:preDay withWeekDay:i];

        [weekList addObject:dateModel];

    }
    
    //当前日期
    [weekList addObject:[self dateModelWithYear:year month:month day:day withWeekDay:weekDay]];
    
    NSInteger totalDays =  [BMTHCalenderTool totalDaysOfMonthInYear:year Month:month];

    //当前日期后同一周补位
    for(int i = 0; i < 7 - weekDay - 1;i++){
        
        NSInteger nexYear = year;
        NSInteger nexMonth = month;
        NSInteger nexDay = day + i + 1;
        
        
        if(nexDay > totalDays){
            
            nexMonth = month + 1;
            nexDay = nexDay - totalDays;
            
            if(nexMonth > 12){
                nexMonth = 1;
                nexYear = year + 1;
            }
        }
        
        id dateModel = [self dateModelWithYear:nexYear month:nexMonth day:nexDay withWeekDay:weekDay + 7 - weekDay - 1 - i];
        
        [weekList addObject:dateModel];

    }
    
    return weekList;
    
}

#pragma mark - MonthList
+ (NSInteger)totalDaysInOnePage
{
    return 7 * 6;
}

+ (NSArray *)getTotalDayslistofPageInYear:(NSInteger)year month:(NSInteger)month
{
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    //上月补位
    NSMutableArray * totalDayList = [NSMutableArray arrayWithCapacity:[self totalDaysInOnePage]];
    [totalDayList addObjectsFromArray:[self preMonthDaySpacingAtCurYear:year Month:month]];
    
    
    //当月
    [totalDayList addObjectsFromArray:[self curMonthDaySpacingAtCurYear:year Month:month]];
    
    //下月补位
    [totalDayList addObjectsFromArray:[self nextMonthDaySpacingAtCurYear:year Month:month]];
    
    return totalDayList;
}


/*
 * 获取当月的天数
 */

+ (NSArray *)curMonthDaySpacingAtCurYear:(NSInteger)year Month:(NSInteger)month
{
    //当前月份
    NSInteger totalMouthDay = [BMTHCalenderTool totalDaysOfMonthInYear:year Month:month];
    NSInteger firstWeekInMouth = [BMTHCalenderTool getWeekOfFirstDayOfyear:year withMonth:month];

    NSMutableArray * curDayList = [NSMutableArray arrayWithCapacity:totalMouthDay];
    for (NSInteger i = 0; i < totalMouthDay; i++) {
        
        id dateModel = [self dateModelWithYear:year month:month day:i + 1 withWeekDay:(firstWeekInMouth + i) % 7];
        [curDayList addObject:dateModel];
    }
    return curDayList;
}

/*
 * 获取上一个月的补位
 */
+ (NSArray *)preMonthDaySpacingAtCurYear:(NSInteger)year Month:(NSInteger)month
{
    NSInteger firstWeekInMouth = [BMTHCalenderTool getWeekOfFirstDayOfyear:year withMonth:month];

    //上一个月份
    NSInteger preYear = year;
    NSInteger preMonth = month - 1;
    
    if(preMonth <= 0){
        preMonth = 12;
        preYear = year - 1;
    }
    
    NSInteger pTotalMouthDay = [BMTHCalenderTool totalDaysOfMonthInYear:preYear Month:preMonth];
    
    NSMutableArray * preDayLit = [NSMutableArray arrayWithCapacity:0];
    //上一个月补位
    for (NSInteger i = 0; i < firstWeekInMouth; i++) {
        
        id dateModel = [self dateModelWithYear:preYear month:preMonth day:pTotalMouthDay - firstWeekInMouth + i + 1 withWeekDay:i];
        [preDayLit addObject:dateModel];
        
    }
    return preDayLit;
}

/*
 * 获取下一个月的补位
 */

+ (NSArray *)nextMonthDaySpacingAtCurYear:(NSInteger)year  Month:(NSInteger)month
{
    //下一月份
    NSInteger nexYear = year;
    NSInteger nexMonth = month + 1;
    
    if (nexMonth > 12) {
        nexMonth = 1;
        nexYear = year + 1;
    }
    
    NSMutableArray * nexDayList = [NSMutableArray arrayWithCapacity:0];

    NSInteger totalMouthDay = [BMTHCalenderTool totalDaysOfMonthInYear:year Month:month];
    NSInteger firstWeekInMouth = [BMTHCalenderTool getWeekOfFirstDayOfyear:year withMonth:month];

    //下一个月补位
    for(NSInteger i = 0; i < [self totalDaysInOnePage] - firstWeekInMouth - totalMouthDay;i++){
        id dateModel = [self dateModelWithYear:nexYear month:nexMonth day:i+1 withWeekDay:7 - ([self totalDaysInOnePage] - firstWeekInMouth - totalMouthDay - i) % 7];
        [nexDayList addObject:dateModel];
    }

    return nexDayList;
}


#pragma mark DateModel
+ (BMTHCalenderModel *)dateModelWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day withWeekDay:(NSInteger)weekDay
{
    
    BMTHCalenderModel * model = [[BMTHCalenderModel alloc] init];
    model.year = year;
    model.month = month;
    model.day = day;
    model.weekDay = weekDay % 7;
    
    return model;
    
    //    return [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
}

@end
