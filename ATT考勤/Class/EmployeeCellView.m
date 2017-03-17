//
//  EmployeeCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "EmployeeCellView.h"

@interface EmployeeCellView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UIView *line;

@end

@implementation EmployeeCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:20]);
        make.left.equalTo([self h_w:10]);
    }];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.content.mas_bottom).offset([self h_w:18]);
        make.left.equalTo([self h_w:10]);
    }];

    [self.show mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.content];
    [self addSubview:self.show];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setEmployeeModel:(EmployeeModel *)employeeModel{
    if (!employeeModel) {
        return;
    }
    _employeeModel = employeeModel;
    
    switch (self.index) {
//        case 0:
//            self.content.text = employeeModel.empName;
//            break;
//        case 1:
//            self.content.text = employeeModel.empSex;
//            break;
//    
//        case 2:
//            self.content.text = employeeModel.empBirthDate;
//            break;
        case 0:
            self.content.text = employeeModel.position;
            break;
        case 1:
            self.content.text = employeeModel.empTelphone;
            break;
        case 2:
            self.content.text = employeeModel.empEmail;
            break;
        case 3:
            self.content.text = employeeModel.phoneDeviceName;
            break;
    }
    

}


-(void)setEmployeeTitle:(EmployeeTitle *)employeeTitle{
    if (!employeeTitle) {
        return;
    }
    _employeeTitle = employeeTitle;
    self.title.text = employeeTitle.title;
//    self.content.text = employeeModel.content;
    self.show.image = ImageNamed(employeeTitle.show);

}

#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
        _title.font = H12;
        _title.textColor = MAIN_PAN;
    }
    return _title;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"";
        _content.font = H12;
        _content.textColor = MAIN_PAN_2;
    }
    return _content;
}

-(UIImageView *)show{
    if (!_show) {
        _show = [[UIImageView alloc] init];
        _show.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        [_show addGestureRecognizer:setTap];
        
    }
    return _show;
}

-(void)onClick:(UITapGestureRecognizer *)setTap{
   UIView *view = [setTap view];
    if ([view tag] == 0) {
        NSString *allString = [NSString stringWithFormat:@"tel:%@", self.employeeModel.empTelphone];
        ShowMessage(allString);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
    }
   
    if ([view tag] == 2) {
        ShowMessage(@"暂时没开通邮箱");
    }
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
