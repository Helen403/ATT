//
//  IconView.m
//  ATT考勤
//
//  Created by Helen on 17/3/28.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "IconView.h"

@interface IconView()

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,assign) CGRect frameTmp;

@end

@implementation IconView
#pragma mark system
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frameTmp = frame;
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    [self addSubview:self.bgView];
    [self addSubview:self.name];
}


-(void)setContent:(NSString *)content and:(UIColor *)color{
    if ([LSCoreToolCenter PureLetters:content]) {
        self.name.text = content;
    }else{
        if (content.length==3) {
            self.name.text = [content  substringFromIndex:1];
        }else{
            self.name.text = content;
        }
    }

    self.bgView.backgroundColor = color;
}

#pragma mark lazydata
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frameTmp.size.width, self.frameTmp.size.height)];
      
        ViewRadius(_bgView, self.frameTmp.size.width/2);
        
    }
    return _bgView;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frameTmp.size.width, self.frameTmp.size.height)];
        _name.text = @"";
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = H14;
        _name.textColor = white_color;
    }
    return _name;
}

@end
