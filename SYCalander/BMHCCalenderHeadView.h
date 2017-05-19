//
//  BMHCCalenderHeadView.h
//
//  Created by Linjunhou on 2016/11/21.
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


