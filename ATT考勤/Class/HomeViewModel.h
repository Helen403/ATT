//
//  HomeViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/21.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface HomeViewModel : HViewModel

@property(nonatomic,strong) RACSubject *headclickSubject;

@property(nonatomic,strong) RACSubject *setClickSubject;



@end
