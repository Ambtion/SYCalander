//
//  BMHCCalenderHeadView.h
//  basicmap
//
//  Created by quke on 2016/11/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BMHCCalenderHeadViewDelegate <NSObject>

@optional
- (void)onPreviousClick:(id)sender;
- (void)onNextClick:(id)sender;

@end

@interface BMHCCalenderHeadView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) id<BMHCCalenderHeadViewDelegate> delegate;

@end


