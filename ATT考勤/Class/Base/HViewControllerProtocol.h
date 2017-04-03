//
//  HViewControllerProtocol.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HViewModelProtocol;

@protocol HViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <HViewModelProtocol>)viewModel;


- (void)h_layoutNavigation;//设置导航栏、分栏
- (void)h_addSubviews;//添加View到ViewController
- (void)h_bindViewModel;//用来绑定V(VC)与VM
- (void)h_loadData;//初次获取数据的时候调用（不是特别必要)
- (void)h_recoverKeyboard;
- (void)h_viewWillAppear;
- (void)h_viewWillDisappear;

- (void)h_back;
@end
