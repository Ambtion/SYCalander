//
//  BMTHCanlenderCell.m
//
//  Created by Linjunhou on 2016/11/21.
//

#import "BMTHCanlenderCell.h"

@interface BMTHCanlenderCell()

@property(nonatomic,strong)UILabel * dayTitle;
@property(nonatomic,strong)UIView * seletedBgView;
@property(nonatomic,strong)UIView * pointArrowView;
@property(nonatomic,assign)BOOL isToday;
@end

@implementation BMTHCanlenderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.seletedBgView = [[UIView alloc] init];
    self.seletedBgView.backgroundColor = UIColorFromRGB(0x333333);
    self.seletedBgView.layer.cornerRadius = 35/2.f;
    self.seletedBgView.clipsToBounds = YES;
    [self addSubview:self.seletedBgView];
    
    [self.seletedBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    self.dayTitle = [[UILabel alloc] init];
    self.dayTitle.font = [UIFont boldSystemFontOfSize:18.f];
    self.dayTitle.textColor = UIColorFromRGB(0x333333);
    self.dayTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dayTitle];
    
    [self.dayTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    self.pointArrowView = [[UIView alloc] init];
    [self addSubview:self.pointArrowView];
    self.pointArrowView.backgroundColor = UIColorFromRGB(0xb5b5b5);
    self.pointArrowView.clipsToBounds = YES;
    self.pointArrowView.layer.cornerRadius = 1.5;
    
    [self.pointArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(3, 3));
        make.centerX.equalTo(self);
        make.top.equalTo(self.dayTitle.mas_bottom).offset(1);
    }];
    
    [self setHasTrip:NO];
    [self setIsSeleted:NO];
    self.isToday = NO;

}

- (void)setModel:(BMTHCalenderModel *)model
{
    
    if (_model == model) {
        return;
    }
    
    _model = model;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *curComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    self.isToday =  curComp.year == model.year && curComp.month == model.month && curComp.day == model.day;
    if (self.isToday) {
        self.dayTitle.font = [UIFont boldSystemFontOfSize:14];
        self.dayTitle.text = @"今天";
    } else {
        self.dayTitle.font = [UIFont boldSystemFontOfSize:18];
        self.dayTitle.text = [NSString stringWithFormat:@"%ld",(long)model.day];
    }
    [self refreshTextColor];
}

- (void)refreshTextColor
{
    
    if (self.todayForce) {
        [self.pointArrowView setHidden:YES];
        [self.seletedBgView setHidden:NO];
        self.dayTitle.textColor = UIColorFromRGB(0xffffff);
//        [self setUserInteractionEnabled:NO];
        self.canBeOper = NO;
    }else{
        [self.pointArrowView setHidden:!self.hasTrip];
        [self.seletedBgView setHidden:!self.isSeleted];
//        [self setUserInteractionEnabled:self.hasTrip];
        self.canBeOper = self.hasTrip;
        
        
        /*
         * 1: 有行程，  选择 0xffffff
         * 2: 有行程,   不选择 0x999999
         * 3: 无行程（肯定不选择） 0xdfdfdf
         */
        if (self.hasTrip) {
            if(self.isSeleted){
                self.dayTitle.textColor = UIColorFromRGB(0xffffff);
                self.pointArrowView.backgroundColor = UIColorFromRGB(0xffffff);
            }else{
//                if (self.isToday) {
//                    self.dayTitle.textColor = UIColorFromRGB(0xf7be00);
//                }else{
//                    self.dayTitle.textColor = UIColorFromRGB(0x999999);
//                }
                self.dayTitle.textColor = UIColorFromRGB(0x333333);
                self.pointArrowView.backgroundColor = UIColorFromRGB(0xb5b5b5);
            }
        }else{
            self.dayTitle.textColor = UIColorFromRGB(0xbbbbbb);
        }
 
    }

}

- (void)setTodayForce:(BOOL)todayForce
{
    _todayForce = todayForce;
    [self refreshTextColor];
}

#pragma mark -
- (void)setIsSeleted:(BOOL)isSeleted
{
    _isSeleted = isSeleted;
    [self refreshTextColor];
}

- (void)setHasTrip:(BOOL)hasTrip
{
    _hasTrip = hasTrip;
    [self refreshTextColor];
}

@end
