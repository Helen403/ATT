//
//  TeamOutWorkDetailsCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamOutWorkDetailsCellView.h"

@interface TeamOutWorkDetailsCellView()

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *time1;

@property(nonatomic,strong) UILabel *address;

@property(nonatomic,strong) UILabel *loc;

@property(nonatomic,strong) UILabel *time2;

@property(nonatomic,strong) UILabel *net;

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UIView *line;

@end

@implementation TeamOutWorkDetailsCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.time1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.name);
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        make.top.equalTo(weakSelf.name);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.name);
        make.top.equalTo(weakSelf.name.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.loc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.name);
        make.top.equalTo(weakSelf.address.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.time2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.name);
        make.top.equalTo(weakSelf.loc.mas_bottom).offset([self h_w:10]);
    }];
    
    
    [self.net mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.name);
        make.top.equalTo(weakSelf.time2.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.name];
    [self addSubview:self.time1];
    [self addSubview:self.address];
    [self addSubview:self.loc];
    [self addSubview:self.time2];
    [self addSubview:self.net];
    [self addSubview:self.img];
    [self addSubview:self.line];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setTeamOutWorkDetailsModel:(TeamOutWorkDetailsModel *)teamOutWorkDetailsModel{
    if (!teamOutWorkDetailsModel) {
        return;
    }
    _teamOutWorkDetailsModel = teamOutWorkDetailsModel;
    
    self.name.text = teamOutWorkDetailsModel.empName;
    self.time1.text =[LSCoreToolCenter getFormatterYMD:[teamOutWorkDetailsModel.startDate substringToIndex:10]] ;
    self.address.text =[NSString stringWithFormat:@"地点:%@",teamOutWorkDetailsModel.outAddress] ;
    self.loc.text =[NSString stringWithFormat:@"定位:%@",teamOutWorkDetailsModel.locAddress] ;
    
    self.time2.text =[NSString stringWithFormat:@"时间:%@至%@",[LSCoreToolCenter getFormatterYMDHM:teamOutWorkDetailsModel.startDate],[LSCoreToolCenter getFormatterYMDHM:teamOutWorkDetailsModel.endDate]];
    self.net.text =[NSString stringWithFormat:@"网络:%@",teamOutWorkDetailsModel.cloclMode];
    
}


#pragma mark lazyload
-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"";
        _name.font = H14;
        _name.textColor = MAIN_PAN_2;
    }
    return _name;
}

-(UILabel *)time1{
    if (!_time1) {
        _time1 = [[UILabel alloc] init];
        _time1.text = @"";
        _time1.font = H14;
        _time1.textColor = MAIN_PAN_2;
    }
    return _time1;
}
-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.text = @"";
        _address.font = H14;
        _address.textColor = MAIN_PAN_2;
    }
    return _address;
}
-(UILabel *)loc{
    if (!_loc) {
        _loc = [[UILabel alloc] init];
        _loc.text = @"";
        _loc.font = H14;
        _loc.textColor = MAIN_PAN_2;
    }
    return _loc;
}
-(UILabel *)time2{
    if (!_time2) {
        _time2 = [[UILabel alloc] init];
        _time2.text = @"";
        _time2.font = H14;
        _time2.textColor = MAIN_PAN_2;
    }
    return _time2;
}

-(UILabel *)net{
    if (!_net) {
        _net = [[UILabel alloc] init];
        _net.text = @"";
        _net.font = H14;
        _net.textColor = MAIN_PAN_2;
    }
    return _net;
}

-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        //_img.image = ImageNamed(@"map_loc_address");
    }
    return _img;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
