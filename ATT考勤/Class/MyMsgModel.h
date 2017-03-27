//
//  MyMsgModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMsgModel : NSObject

@property(nonatomic,strong) NSString *img;

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *content;

@property(nonatomic,strong) NSString *time;


@property (nonatomic , copy) NSString              * msgSize;
@property (nonatomic , copy) NSString              * msgUserCode;
@property (nonatomic , copy) NSString              * msgUserName;
@property (nonatomic , copy) NSString              * msgLast;
@property (nonatomic , copy) NSString              * msgDate;

@end
