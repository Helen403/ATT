//
//  LoginTableCell.m
//  ATT考勤
//
//  Created by Helen on 16/12/17.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "LoginTableCell.h"


@interface LoginTableCell()

@property(nonatomic,strong) UIImageView *headerImageView;

@property(nonatomic,strong) UILabel *nameLabel;


@end

@implementation LoginTableCell

#pragma mark private
-(void)h_setupViews{

    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLabel];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{

}

-(void)updateConstraints{
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(paddingEdge);
        make.centerY.equalTo(weakSelf.contentView);
        make.size.equalTo(CGSizeMake(80, 80));
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.headerImageView.mas_right).offset(paddingEdge);
        make.top.equalTo(weakSelf.headerImageView);
        make.right.equalTo(-paddingEdge);
        make.height.equalTo(15);
    }];
   [super updateConstraints];
}

#pragma mark 设置数据
-(void)setLoginViewCellViewModel:(LoginViewCellModel *)loginViewCellViewModel{
    if (!loginViewCellViewModel) {
        return;
    }
  
    _loginViewCellViewModel = loginViewCellViewModel;
    
    [self.headerImageView sd_setImageWithURL:URL(loginViewCellViewModel.headImgStr)];
    
    self.nameLabel.text = loginViewCellViewModel.name;
}


#pragma mark lazyload
-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
    }
    return _headerImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}


@end
