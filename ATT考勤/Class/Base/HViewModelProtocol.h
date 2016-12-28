//
//  HViewModelProtocol.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMRequest.h"
typedef enum : NSUInteger {
    HeaderRefresh_HasMoreData = 1,
    HeaderRefresh_HasNoMoreData,
    FooterRefresh_HasMoreData,
    FooterRefresh_HasNoMoreData,
    RefreshError,
    RefreshUI,
} RefreshDataStatus;

typedef enum:NSUInteger{
    HSuccess = 1,
    HFailure,
} HStatus;


@protocol HViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

@property (strong, nonatomic)CMRequest *request;

/**
 *  初始化
 */
- (void)h_initialize;

@end