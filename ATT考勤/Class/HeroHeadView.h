//
//  HeroHeadView.h
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HView.h"
#import "HeroModel.h"

@interface HeroHeadView : HView

@property(nonatomic,strong) HeroModel *heroModel;

@property(nonatomic,assign) NSInteger index;


@end
