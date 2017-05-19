//
//  BMHCCalenderTabView.m
//  basicmap
//
//  Created by quke on 2016/11/21.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BMHCCalenderTabView.h"
#import "BMTHTripCalenderTool.h"
#import "BMHCTabCanlenderCell.h"
#import "BMTHWeekTitleHeadView.h"
#import "BMCustomShowMessage.h"

@interface BMHCCalenderTabView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView * collecView;
@property (nonatomic,strong) UIView* lineView;

@property(nonatomic,strong)NSArray * dataSource;

@end

@implementation BMHCCalenderTabView

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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collecView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self.collecView setDataSource:self];
    [self.collecView setDelegate:self];
    self.collecView.backgroundColor = UIColorFromRGB(0xffffff);
    [self.collecView setScrollEnabled:NO];
    [self addSubview:self.collecView];
    
    [self.collecView registerClass:[BMHCTabCanlenderCell class] forCellWithReuseIdentifier:NSStringFromClass([BMHCTabCanlenderCell class])];
    [self.collecView registerClass:[BMTHWeekTitleHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BMTHWeekTitleHeadView class])];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom-.5, self.width, .5)];
    self.lineView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self addSubview:self.lineView];
}

- (void)seletedContentDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    self.dataSource = [BMTHTripCalenderTool getWeekDaysListContaitInYear:year month:month day:day];
    [self.collecView reloadData];
}

#pragma mark - UI HEADView
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.width, 12);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        BMTHWeekTitleHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([BMTHWeekTitleHeadView class]) forIndexPath:indexPath];

        return headerView;
    }
    return [UICollectionReusableView new];
    
}


#pragma mark - UI Cus
#pragma mark - UICollectionViewDelegate
static float itemHeigth = 40;
//static float itemSpacing = 5.f;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 9.f, 8, 9.f);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellMargin = (collectionView.width - 18)/7;
    cellMargin = floor(cellMargin*100)/100;
    return CGSizeMake(cellMargin, itemHeigth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     
    BMHCTabCanlenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BMHCTabCanlenderCell class]) forIndexPath:indexPath];
    
    BMTHCalenderModel * model = self.dataSource[indexPath.row];
    cell.model = model;
    
    if([_dataSourceDelegate respondsToSelector:@selector(hcCanlenderTabView:didHasTripWhenInDate:)]){
        cell.hasTrip = [_dataSourceDelegate hcCanlenderTabView:self didHasTripWhenInDate:model];
    }
    if ([_dataSourceDelegate respondsToSelector:@selector(hcCanlenderTabView:didSeletedWhenInDate:)]) {
        cell.isSeleted = [_dataSourceDelegate hcCanlenderTabView:self didSeletedWhenInDate:model];
    }
    
    if ([_dataSourceDelegate respondsToSelector:@selector(hcCanlenderTabView:hasForceTodayWhenInDate:)]) {
        cell.todayForce = [_dataSourceDelegate hcCanlenderTabView:self hasForceTodayWhenInDate:model];
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BMHCTabCanlenderCell *cell = (BMHCTabCanlenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(cell.canBeOper){
        if ([_delegate respondsToSelector:@selector(hcCalenderPickerView:didSeletedDate:)]) {
            [_delegate hcCalenderPickerView:self didSeletedDate:cell.model];
        }

    }else{
        [[CustomShowMessage getInstance] showNotificationMessage:@"您该日暂无行程"];
    }
}


@end
