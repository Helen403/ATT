//
//  ChatViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ChatViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSString *targetId;

@property(nonatomic,strong) RACSubject *successSubject;

//================================
@property(nonatomic,strong) RACCommand *sendCommand;

@property(nonatomic,strong) NSString *msgSenderId;

@property(nonatomic,strong) NSString *msgSenderName;

@property(nonatomic,strong) NSString *msgReceId;

@property(nonatomic,strong) NSString *msgReceName;

@property(nonatomic,strong) NSString *msgSendDate;

@property(nonatomic,strong) NSString *msgType;

@property(nonatomic,strong) NSString *msgContents;

@property(nonatomic,strong) NSString *msgVolumnTime;

@end
