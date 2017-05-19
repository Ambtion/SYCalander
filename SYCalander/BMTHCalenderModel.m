//
//  BMTHCalenderModel.m
//
//  Created by Linjunhou on 2016/11/21.
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
