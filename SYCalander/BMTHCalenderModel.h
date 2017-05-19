//
//  BMTHCalenderModel.h
//
//  Created by Linjunhou on 2016/11/21.
//

#import <Foundation/Foundation.h>

@interface BMTHCalenderModel : NSObject

@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger day;

@property(nonatomic,assign)NSInteger weekDay;  // 0 == 周日， 1 = 周一 ...

- (instancetype)initWithDate:(NSDate *)date;

@end
