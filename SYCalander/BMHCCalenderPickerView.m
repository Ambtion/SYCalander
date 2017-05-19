//
//  BMHCCalenderPickerView.m
//
//  Created by Linjunhou on 2016/11/21.
//

#import "BMHCCalenderPickerView.h"
#import "BMTHTripCalenderTool.h"
#import "BMTHCanlenderCell.h"
#import "BMHCCalenderHeadView.h"

@interface BMHCCalenderPickerView()<UICollectionViewDelegate,UICollectionViewDataSource,BMHCCalenderHeadViewDelegate>

@property(nonatomic,strong)UICollectionView * collecView;

@property(nonatomic,strong)NSArray * dataSource;

@property(nonatomic,assign)NSInteger seletedYear;
@property(nonatomic,assign)NSInteger seletedMonth;

@end

@implementation BMHCCalenderPickerView


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
    [self.collecView setBackgroundColor:[UIColor whiteColor]];
    [self.collecView setScrollEnabled:NO];
    [self addSubview:self.collecView];
    
    [self.collecView registerClass:[BMTHCanlenderCell class] forCellWithReuseIdentifier:NSStringFromClass([BMTHCanlenderCell class])];
    [self.collecView registerClass:[BMHCCalenderHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BMHCCalenderHeadView class])];
}

- (void)seletedContentDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    self.seletedYear = year;
    self.seletedMonth = month;
    [self updateUI];
}

- (void)updateUI
{
    self.dataSource = [BMTHTripCalenderTool getTotalDayslistofPageInYear:self.seletedYear month:self.seletedMonth];
    [self.collecView reloadData];
}

- (NSString*)formatRoundHalfDown:(NSInteger)month
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *text = [formatter stringFromNumber:[NSNumber numberWithInteger:month]];
    return text;
}

#pragma mark - UI HEADView
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.width, 63);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        BMHCCalenderHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([BMHCCalenderHeadView class]) forIndexPath:indexPath];
        [self formatRoundHalfDown:self.seletedMonth];
        headerView.titleLabel.text = [[NSString alloc] initWithFormat:@"%ld年%@月",(long)self.seletedYear,
                                      [self formatRoundHalfDown:self.seletedMonth]];
        [headerView setDelegate:self];
        return headerView;
    }
    return [UICollectionReusableView new];
}

- (void)onPreviousClick:(id)sender {
    if (self.seletedMonth > 1) {
        self.seletedMonth -= 1;
    } else {
        self.seletedMonth = 12;
        self.seletedYear -= 1;
    }
    [self updateUI];
}

- (void)onNextClick:(id)sender {
    if (self.seletedMonth < 12) {
        self.seletedMonth += 1;
    } else {
        self.seletedMonth = 1;
        self.seletedYear += 1;
    }
    [self updateUI];
}


#pragma mark - UI Cus
#pragma mark - UICollectionViewDelegate
static float itemHeigth = 42.f;
//static float itemSpacing = 5.f;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 9.f, 10, 9.f);
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    BMTHCanlenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BMTHCanlenderCell class]) forIndexPath:indexPath];
        
    BMTHCalenderModel * model = self.dataSource[indexPath.row];
    cell.model = model;
    if([_dataSourceDelegate respondsToSelector:@selector(hcCalenderPickerView:didHasTripWhenInDate:)]){
        cell.hasTrip = [_dataSourceDelegate hcCalenderPickerView:self didHasTripWhenInDate:model];
    }
    if ([_dataSourceDelegate respondsToSelector:@selector(hcCalenderPickerView:didSeletedDate:)]) {
        cell.isSeleted = [_dataSourceDelegate hcCalenderPickerView:self didSeltedWhenInDate:model];
    }
    
    if ([_dataSourceDelegate respondsToSelector:@selector(hcCalenderPickerView:hasForceTodayWhenInDate:)]) {
        cell.todayForce = [_dataSourceDelegate hcCalenderPickerView:self hasForceTodayWhenInDate:model];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMTHCanlenderCell *cell = (BMTHCanlenderCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.canBeOper) {
        if ([_delegate respondsToSelector:@selector(hcCalenderPickerView:didSeletedDate:)]) {
            [_delegate hcCalenderPickerView:self didSeletedDate:cell.model];
        }
        

    }else{

    }
}

@end
