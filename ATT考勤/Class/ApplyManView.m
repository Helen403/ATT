//
//  ApplyManView.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplyManView.h"
#import "ApplyManCellView.h"
#import "ApplyManViewModel.h"
#import "ChoiceStaffTeamController.h"
#import "TeamListModel.h"

@interface ApplyManView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) ApplyManViewModel *applyManViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *Img;

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ApplyManView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.applyManViewModel = (ApplyManViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark system
-(void)updateConstraints{
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:6]);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:7]);
        make.left.equalTo([self h_w:10]);
        make.right.equalTo(-[self h_w:10]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:40]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.collectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.applyManViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyManViewRefresh:) name:@"ApplyManView" object:nil];
    
}


-(void)applyManViewRefresh:(NSNotification*) notification{
    NSMutableArray *arrTemp = [notification object];
    NSInteger count = self.applyManViewModel.arr.count;
    int index = 1;
    for(int i = 0;i<arrTemp.count;i++){
        TeamListModel *teamListModel = arrTemp[i];
        index = 1;
        for(int j = 0;j<count;j++){
            TeamListModel *teamListTmp = self.applyManViewModel.arr[j];
            if ([teamListTmp.empName isEqualToString:teamListModel.empName]) {
                index = 0;
                break;
            }
        }
        if (index==1) {
            [self.applyManViewModel.arr insertObject:teamListModel atIndex:0];
        }
        
    }
    
    
    [self.collectionView reloadData];
}

-(void)mainThread{
    
    ChoiceStaffTeamController *choiceStaffTeam = [[ChoiceStaffTeamController alloc] init];
    
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:choiceStaffTeam animated:NO];
}



#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"抄送(点+添加)";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UIImageView *)Img{
    if (!_Img) {
        _Img = [[UIImageView alloc] init];
        _Img.image = ImageNamed(@"create_org");
    }
    return _Img;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置每个item的大小为100*100
        
        layout.footerReferenceSize =CGSizeMake(SCREEN_WIDTH, [self h_w:60]);
        
        
        layout.itemSize = CGSizeMake( [self h_w:40],[self h_w:40]);
        //创建collectionView 通过一个布局策略layout来创建
        _collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        //代理设置
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        
        //注册item类型 这里使用系统的类型
        [_collectionView registerClass:[ApplyManCellView class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ApplyManCellView class])]];
    }
    
    return _collectionView;
}


#pragma delegate
//这是正确的方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ApplyManCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ApplyManCellView class])] forIndexPath:indexPath];
    
    cell.teamListModel = self.applyManViewModel.arr[indexPath.row];
    return cell;
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.applyManViewModel.arr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.applyManViewModel.arr.count-1) {
        NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
        [self.applyManViewModel.cellclickSubject sendNext:row];
    }else{
        TeamListModel *teamListModel = self.applyManViewModel.arr[indexPath.row];
        [self.applyManViewModel.arr removeObject:teamListModel];
        [self.collectionView reloadData];
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 7;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(void)dealloc{
    
    [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"ApplyManView" object:nil];
}

@end
