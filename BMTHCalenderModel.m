//
//  BMTHCalenderModel.m
//  basicmap
//
//  Created by quke on 2016/11/18.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BMTHCalenderModel.h"

@implementation BMTHCalenderModel

- (instancetype)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *dateComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
        self.year = [dateComp year];
        self.month = [dateComp month];
        self.day = [dateComp day];
    
    }
    return self;
}

@end
