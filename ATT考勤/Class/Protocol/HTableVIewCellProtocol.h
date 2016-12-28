//
//  HTableVIewCellProtocol.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTableVIewCellProtocol <NSObject>
@optional

- (void)h_setupViews;
- (void)h_bindViewModel;

@end
