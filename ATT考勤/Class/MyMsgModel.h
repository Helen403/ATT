//
//  MyMsgModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMsgModel : NSObject


@property (nonatomic , copy) NSString              * msgSize;
@property (nonatomic , copy) NSString              * msgUserCode;
@property (nonatomic , copy) NSString              * msgUserName;
@property (nonatomic , copy) NSString              * msgLast;
@property (nonatomic , copy) NSString              * msgDate;
@property(nonatomic,strong) NSString *empColor;

@end
