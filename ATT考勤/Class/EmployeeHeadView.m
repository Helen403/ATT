//
//  EmployeeHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "EmployeeHeadView.h"
#import "UserModel.h"

@interface EmployeeHeadView()

@property(nonatomic,strong) UIImageView *bgImg;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *autograph;

@property(nonatomic,strong) UIImageView *star;

@property(nonatomic,strong) UILabel *img;

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UIView *titleView;

@property(nonatomic,strong) UILabel *titleViewText;

@property(nonatomic,strong) RACCommand *refreshDataCommand;


@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *myEmpCode;

@property(nonatomic,strong) NSString *friendEmpCode;


@end

@implementation EmployeeHeadView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:30]);
    }];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.bottom.equalTo(weakSelf.bgImg).offset(-[self h_w:15]);
        make.size.equalTo(CGSizeMake([self h_w:44], [self h_w:44]));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.view.mas_top).offset([self h_w:7]);
    }];
    
    [self.autograph mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.name.mas_bottom).offset([self h_w:4]);
    }];
    
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgImg.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:30]));
    }];
    
    [self.titleViewText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.titleView);
        make.left.equalTo([self h_w:10]);
    }];
    
    [super updateConstraints];
}



#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.bgImg];
    [self addSubview:self.view];
    [self addSubview:self.img];
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self addSubview:self.autograph];
    [self addSubview:self.star];
    [self addSubview:self.titleView];
    [self addSubview:self.titleViewText];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_bindViewModel{
    [self h_initialize];
}

#pragma mark dataload
-(void)setEmployeeModel:(EmployeeModel *)employeeModel{
    if (!employeeModel) {
        return;
    }
    _employeeModel = employeeModel;
    self.name.text = employeeModel.empName;
    self.autograph.text = employeeModel.position;
    if ([LSCoreToolCenter PureLetters:employeeModel.empName]) {
          self.img.text = employeeModel.empName;
    }else{
        if (employeeModel.empName.length==3) {
            self.img.text = [employeeModel.empName substringFromIndex:1];
        }else{
            self.img.text = employeeModel.empName;
        }
    }

    self.view.backgroundColor = [UIColor colorWithHexString:employeeModel.empColor];

}


#pragma mark lazyload
-(UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] init];
        _bgImg.image = ImageNamed(@"star");
    }
    return _bgImg;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"information_nickname_picture");
    }
    return _icon;
}


-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        //        _name.text = @"黄慧";
        _name.font = H14;
        _name.textColor = white_color;
    }
    return _name;
}

-(UILabel *)autograph{
    if (!_autograph) {
        _autograph = [[UILabel alloc] init];
        //        _autograph.text = @"树欲静而风不止";
        _autograph.font = H12;
        _autograph.textColor = white_color;
    }
    return _autograph;
}

-(UIImageView *)star{
    if (!_star) {
        _star = [[UIImageView alloc] init];
        _star.image = ImageNamed(@"ic_unfavorite");
        _star.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(collectClick)];
        [_star addGestureRecognizer:setTap];
    }
    return _star;
}

-(void)collectClick{
     NSString *empCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"empCode"];
    if ([empCode isEqualToString:self.employeeModel.empCode]) {
        return;
    }
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.companyCode = companyCode;
   
    self.myEmpCode = empCode;
    self.friendEmpCode = self.employeeModel.empCode;
    [self.refreshDataCommand execute:nil];
}


-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        
        ViewRadius(_view, [self h_w:22]);
    }
    return _view;
}


-(UILabel *)img{
    if (!_img) {
        _img = [[UILabel alloc] init];
        _img.text = @"";
        _img.font = H16;
        _img.textColor = white_color;
    }
    return _img;
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = GX_BGCOLOR;
    }
    return _titleView;
}

-(UILabel *)titleViewText{
    if (!_titleViewText) {
        _titleViewText = [[UILabel alloc] init];
        _titleViewText.text = @"基本信息";
        _titleViewText.font = H13;
        _titleViewText.textColor = MAIN_PAN_3;
    }
    return _titleViewText;
}
#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        
        NSString *xmlDoc = [LSCoreToolCenter getFilterStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"修改成功");
          
        }else{
            ShowErrorStatus(@"修改失败");
        }
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}


- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<saveMyEmpFriends xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <myEmpCode xmlns=\"\">%@</myEmpCode>\
                                 <friendEmpCode xmlns=\"\">%@</friendEmpCode>\
                                 </saveMyEmpFriends>",self.companyCode,self.myEmpCode,self.friendEmpCode];
                
                [LSCoreToolCenter SOAPData:saveMyEmpFriends soapBody:body success:^(NSString *result) {
                    
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


@end
