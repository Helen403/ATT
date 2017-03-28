//
//  ChatModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

@property (nonatomic , copy) NSString              * msgSenderName;
@property (nonatomic , copy) NSString              * msgType;
@property (nonatomic , copy) NSString              * msgVolumnTime;
@property (nonatomic , copy) NSString              * msgSendDate;
@property (nonatomic , copy) NSString              * msgReceName;
@property (nonatomic , copy) NSString              * companyCode;
@property (nonatomic , copy) NSString              * msgReceDate;
@property (nonatomic , copy) NSString              * msgId;
@property (nonatomic , copy) NSString              * msgContents;
@property (nonatomic , copy) NSString              * msgReceId;
@property (nonatomic , copy) NSString              * msgSenderId;

@end
