//
//  ResignationView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplyView.h"
#import "ResignationViewModel.h"
#import "ApplyView.h"


@interface ApplyView ()

@property(nonatomic,strong) ResignationViewModel *resignationViewModel;

@end
@implementation ApplyView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{

    self.resignationViewModel = (ResignationViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}



@end
