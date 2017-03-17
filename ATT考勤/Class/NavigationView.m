//
//  NavigationView.m
//  ATT考勤
//
//  Created by Helen on 17/3/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView

#pragma mark system
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        CGSize size=[UIImage imageNamed:@"login_ATT_picture"].size;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200, size.width, size.height)];
        img.image = ImageNamed(@"login_ATT_picture");
        img.center = CGPointMake(SCREEN_WIDTH/2.f, SCREEN_HEIGHT-80);
        [self addSubview:img];
        
        UILabel  *title = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 30)];
        title.text = @"2016-2017中山韦达信息技术有限公司";
        title.font = H14;
        title.textColor = MAIN_PAN_3;
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
    }
    return self;
}

@end
