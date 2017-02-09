//
//  MyExamineView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyExamineView.h"
#import "MyExamineViewModel.h"
#import "MyExamineTableCellView.h"

@interface MyExamineView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MyExamineViewModel *myExamineViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation MyExamineView
#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{

    self.myExamineViewModel = (MyExamineViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}


-(void)updateConstraints{

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        make.top.equalTo(3);
    }];
    
    [super updateConstraints];

}

#pragma mark private
-(void)h_setupViews{

    
    self.backgroundColor = GX_BGCOLOR;
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_bindViewModel{
    [self addDynamic];
}

-(void)addDynamic{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
    [self addGestureRecognizer:setTap];
}

-(void)onClick:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    
    [self addSubview:self.rippleView];
    self.rippleView.center = point;
    self.rippleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.1
                     animations:^{
                         self.rippleView.alpha=1;
                     }];
    [UIView animateWithDuration:0.7
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.rippleView.transform = CGAffineTransformMakeScale(1,1);
                         self.rippleView.alpha=0;
                     } completion:^(BOOL finished) {
                         
                         [self.rippleView removeFromSuperview];
                     }];
}


#pragma mark lazyload
-(MyExamineViewModel *)myExamineViewModel{
    if (!_myExamineViewModel) {
        _myExamineViewModel = [[MyExamineViewModel alloc] init];
    }
    return _myExamineViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyExamineTableCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyExamineTableCellView class])]];
        _tableView.scrollEnabled = NO;
        
        
    }
    return _tableView;

}

#pragma mark - delegate
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyExamineTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyExamineTableCellView class])] forIndexPath:indexPath];
    
    cell.myExamineModel = self.myExamineViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.myExamineViewModel.cellclickSubject sendNext:row];
}





@end
