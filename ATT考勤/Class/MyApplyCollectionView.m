//
//  MyApplyCollectionView.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyApplyCollectionView.h"



@interface MyApplyCollectionView()



@property(nonatomic,strong) UIImageView *headerImageView;

@property(nonatomic,strong) UILabel *nameLabel;

@end


@implementation MyApplyCollectionView

#pragma mark system
-(void)updateConstraints{
    WS(weakSelf)
    
    CGFloat paddingEdge = -6;
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(paddingEdge);
    }];
    [super updateConstraints];
}



#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = white_color;
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    
}


#pragma mark 设置数据
-(void)setMyApplyModel:(MyApplyModel *)myApplyModel{
    if (!myApplyModel) {
        return;
    }
    
    _myApplyModel = myApplyModel;
    
    [self.headerImageView setImage:ImageNamed(myApplyModel.Img)];
    
    self.nameLabel.text = myApplyModel.title;
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
        _nameLabel.font = H14;
        _nameLabel.textColor = MAIN_PAN;
    }
    return _nameLabel;
}




@end
