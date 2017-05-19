//
//  SYTHTripCalenderTool.h
//
//  Created by Linjunhou on 2016/11/18.
//

#import <Foundation/Foundation.h>

@interface SYTHTripCalenderTool : NSObject

/*
 * 一页展示的天数 目前是 7 * 6
 */
+ (NSInteger)totalDaysInOnePage;

/*
 * 获取某年某月在一个页面显示的天数
 */
+ (NSArray *)getTotalDayslistofPageInYear:(NSInteger)year month:(NSInteger)month;


/*
 * 获取某年某月某天所在一周的天数列表
 */
+ (NSArray *)getWeekDaysListContaitInYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
