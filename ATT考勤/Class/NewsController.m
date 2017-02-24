//
//  NewsController.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NewsController.h"
#import "NewsViewModel.h"
#import "NewsView.h"

#import "InformController.h"
#import "NoticeController.h"
#import "MyMsgController.h"

@interface NewsController ()

@property(nonatomic,strong) NewsViewModel *newsViewModel;

@property(nonatomic,strong) NewsView *newsView;

@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}


#pragma mark private
-(void)h_addSubviews{
    [self.view addSubview:self.newsView];
}

-(void)h_viewWillAppear{
    [self.newsView h_refreash];

}

-(void)h_bindViewModel{
    
    [[self.newsViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        NSInteger row = [x intValue];
        switch (row) {
                //公司公告
            case 0:{
                NoticeController *notice = [[NoticeController alloc] init];
                
                [self.navigationController pushViewController:notice animated:NO];
                 break;
            }
                   //公司通知
            case 1:{
                InformController *inform = [[InformController alloc] init];
                
                [self.navigationController pushViewController:inform animated:NO];
                break;
            }
                
                //我的信息
            case 2:{
                MyMsgController *myMsg = [[MyMsgController alloc] init];
                
                [self.navigationController pushViewController:myMsg animated:NO];
                break;
            }
        }
    }];
}

#pragma mark lazyload
-(NewsView *)newsView{
    if (!_newsView) {
        _newsView = [[NewsView alloc] initWithViewModel:self.newsViewModel];
    }
    return _newsView;
}


-(NewsViewModel *)newsViewModel{
    if (!_newsViewModel) {
        _newsViewModel = [[NewsViewModel alloc] init];
    }
    return _newsViewModel;
}
@end
