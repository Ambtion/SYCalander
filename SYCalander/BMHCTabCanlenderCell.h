//
//  BMHCTabCanlenderCell.h
//  basicmap
//
//  Created by quke on 2016/11/22.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMTHCalenderModel.h"

@interface BMHCTabCanlenderCell : UICollectionViewCell

@property(nonatomic,strong)BMTHCalenderModel * model;

@property(nonatomic,assign)BOOL isSeleted;
@property(nonatomic,assign)BOOL hasTrip;

@property(nonatomic,assign)BOOL todayForce;
@property(nonatomic,assign)BOOL canBeOper;
@end



