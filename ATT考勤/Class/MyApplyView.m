//
//  MyApplyView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyApplyView.h"
#import "MyApplyViewModel.h"
#import "MyApplyCollectionView.h"
#import "MyApplyFootView.h"

@interface MyApplyView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) MyApplyViewModel *myApplyViewModel;

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation MyApplyView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.myApplyViewModel = (MyApplyViewModel *)viewModel;
    return [super initWithViewModel:self.myApplyViewModel];
}


-(void)updateConstraints{
    WS(weakSelf);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = GX_BGCOLOR;
    [self addSubview:self.collectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_bindViewModel{

}

#pragma mark lazyload
-(MyApplyViewModel *)myApplyViewModel{
    
    if (!_myApplyViewModel) {
        _myApplyViewModel = [[MyApplyViewModel alloc] init];
    }
    return _myApplyViewModel;
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小为100*100
        
        layout.footerReferenceSize =CGSizeMake(SCREEN_WIDTH, [self h_w:60]);
        
        CGFloat padding = 6;
        
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-4*padding)/3.f, (SCREEN_WIDTH-4*padding)/3.f);
        //创建collectionView 通过一个布局策略layout来创建
        _collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        
        _collectionView.backgroundColor = GX_BGCOLOR;
        //代理设置
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册item类型 这里使用系统的类型
        [_collectionView registerClass:[MyApplyCollectionView class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyApplyCollectionView class])]];
        
        [_collectionView registerClass:[MyApplyFootView class]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    
    return _collectionView;
}


#pragma delegate
//这是正确的方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyApplyCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyApplyCollectionView class])] forIndexPath:indexPath];
    
    cell.myApplyModel = self.myApplyViewModel.arr[indexPath.row];
    return cell;
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myApplyViewModel.arr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 0, 10);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.myApplyViewModel.cellclickSubject sendNext:row];
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        MyApplyFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer"forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}

@end
