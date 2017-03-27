//
//  AnnouncementModel.h
//  ATT考勤
//
//  Created by Helen on 17/2/28.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnouncementModel : NSObject

@property (nonatomic , copy) NSString              * msgSenderName;
@property (nonatomic , copy) NSString              * msgOffice;
@property (nonatomic , copy) NSString              * msgStatus;
@property (nonatomic , copy) NSString              * msgTitle;
@property (nonatomic , copy) NSString              * msgExpiryDate;
@property (nonatomic , copy) NSString              * companyCode;
@property (nonatomic , copy) NSString              * msgId;
@property (nonatomic , copy) NSString              * msgPublishDate;
@property (nonatomic , copy) NSString              * msgContent;
@property (nonatomic , copy) NSString              * msgSenderId;

@end
