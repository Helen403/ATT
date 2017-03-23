
//
//  TeamDailyDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamDailyDetailsController.h"
#import "TeamDailyDetailsView.h"
#import "TeamDailyDetailsViewModel.h"

@interface TeamDailyDetailsController ()

@property(nonatomic,strong) TeamDailyDetailsView *teamDailyDetailsView;

@property(nonatomic,strong) TeamDailyDetailsViewModel *teamDailyDetailsViewModel;

@end

@implementation TeamDailyDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.teamDailyDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    
}

-(void)h_addSubviews{
    [self.view addSubview:self.teamDailyDetailsView];
}


#pragma mark dataload
-(void)setCardDate:(NSString *)cardDate{
    
    if (!cardDate) {
        return;
    }
    _cardDate = cardDate;
    self.teamDailyDetailsView.deptName = self.deptName;
    self.teamDailyDetailsView.deptCode = self.deptCode;
    self.teamDailyDetailsView.cardDate = cardDate;
    
    self.title = [LSCoreToolCenter getFormatterYMD:cardDate];
}



-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(TeamDailyDetailsView *)teamDailyDetailsView{
    if (!_teamDailyDetailsView) {
        _teamDailyDetailsView = [[TeamDailyDetailsView alloc] initWithViewModel:self.teamDailyDetailsViewModel];
    }
    return _teamDailyDetailsView;
}


-(TeamDailyDetailsViewModel *)teamDailyDetailsViewModel{
    if (!_teamDailyDetailsViewModel) {
        _teamDailyDetailsViewModel = [[TeamDailyDetailsViewModel alloc] init];
    }
    return _teamDailyDetailsViewModel;
}

@end
