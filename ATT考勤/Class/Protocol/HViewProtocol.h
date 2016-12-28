//
//  HViewProtocol.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HViewModelProtocol;

@protocol HViewProtocol  <NSObject>

@optional

- (instancetype)initWithViewModel:(id <HViewModelProtocol>)viewModel;

- (void)h_setupViews;
- (void)h_bindViewModel;
- (void)h_addReturnKeyBoard;
@end
