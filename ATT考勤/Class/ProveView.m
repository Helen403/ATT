//
//  ProveView.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ProveView.h"
#import "ProveModel.h"
#import "ProveCellView.h"
#import "UserModel.h"

@interface ProveView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *tableViewSubject;

@end

@implementation ProveView

#pragma mark system
-(void)updateConstraints{
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(6);
        make.left.equalTo(10);
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
 
    [[self.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {

        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
      
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ProveView" object:self.arr];
        });

    }];
}

-(void)h_loadData{
    [self h_initialize];
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.companyCode = companyCode;
    [self.refreshDataCommand execute:nil];
}

#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"审批人";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
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
        [_collectionView registerClass:[ProveCellView class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ProveCellView class])]];
    }
    
    return _collectionView;
}


#pragma delegate
//这是正确的方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProveCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ProveCellView class])] forIndexPath:indexPath];
    
    cell.proveModel = self.arr[indexPath.row];
    return cell;
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 7;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark private
-(void)h_initialize{
    
//    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        NSString *xmlDoc = [LSCoreToolCenter getFilterStr:result filter1:@"<ns2:findAllFlowDescResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllFlowDescResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[ProveModel class] rowRootName:@"FlowDescs"];
        if (arr.count>1) {
             [arr removeObjectAtIndex:0];
            ProveModel *proveModel = [[ProveModel alloc] init];
            UserModel *user =  getModel(@"user");
            proveModel.whois = user.userNickName;
            proveModel.whoisId = user.userCode;
            [arr insertObject:proveModel atIndex:0];
        }
       
        self.arr = arr;
        [self.tableViewSubject sendNext:nil];
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}

#pragma mark lazyload
-(RACCommand *)refreshDataCommand{
    if (!_refreshDataCommand) {
        
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findAllFlowDesc xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <flowType xmlns=\"\">%@</flowType>\
                                 </findAllFlowDesc>",self.companyCode,self.flowType];
                
                [LSCoreToolCenter SOAPData:findUserByTelphone soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
        
    }
    return _refreshDataCommand;
}

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array] ;
    }
    return _arr;
}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
}


-(void)dealloc{
  [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"ProveView" object:nil];
}

@end
