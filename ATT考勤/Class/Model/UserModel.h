//
//  UserModel.h
//  ATT考勤
//
//  Created by Helen on 17/2/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserModel :NSObject<NSCoding>
@property (nonatomic , copy) NSString              * userNickName;
@property (nonatomic , copy) NSString              * userExpireDatetime;
@property (nonatomic , copy) NSString              * userRealName;
@property (nonatomic , copy) NSString              * userRegistDatetime;
@property (nonatomic , copy) NSString              * userCode;
@property (nonatomic , copy) NSString              * userStatus;
@property (nonatomic , copy) NSString              * userTelphone;
@property (nonatomic , copy) NSString              * userPassword;
@property (nonatomic , copy) NSString              * userActiveCode;
@property (nonatomic , copy) NSString              * userEmail;

@end



