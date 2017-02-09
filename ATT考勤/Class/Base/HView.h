//
//  HView.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HViewProtocol.h"
#import "Toast.h"

@interface HView : UIView <HViewProtocol>

@property(nonatomic,strong) UIView *rippleView;

@property(nonatomic,strong) UIView *tmpView;

-(NSInteger)h_w:(NSInteger)width;

//Toast
-(void)toast:(NSString *)text;


-(void)addDynamic:(UIView *)tmpView;
@end
