//
//  BMTHCalenderModel.h
//  basicmap
//
//  Created by quke on 2016/11/18.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMTHCalenderModel : NSObject

@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger day;

@property(nonatomic,assign)NSInteger weekDay;  // 0 == 周日， 1 = 周一 ...

- (instancetype)initWithDate:(NSDate *)date;

@end
