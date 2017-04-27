//
//  TimeSoundCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/15.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeSoundCellView.h"

@interface TimeSoundCellView()

@property(nonatomic,strong) UILabel *title;



@end

@implementation TimeSoundCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:20], [self h_w:20]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.icon];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload

-(void)setTimeSoundModel:(TimeSoundModel *)timeSoundModel{
    if (!timeSoundModel) {
        return;
    }
    _timeSoundModel =  timeSoundModel;
    self.title.text = timeSoundModel.title;
    if (timeSoundModel.flag) {
        self.icon.hidden = NO;
    }else{
        self.icon.hidden = YES;
    }

}

#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"ic_locus_line_on");
        _icon.hidden = YES;
    }
    return _icon;
}
@end
