//
//  TeamModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamModel : NSObject

@property (nonatomic , copy) NSString              * deptFullName;
@property (nonatomic , copy) NSString              * deptParentCode;
@property (nonatomic , copy) NSString              * deptMasterName;
@property (nonatomic , copy) NSString              * deptMasterTel;
@property (nonatomic , copy) NSString              * deptCode;
@property (nonatomic , copy) NSString              * deptNickName;
@property (nonatomic , copy) NSString              * deptStatus;
@property (nonatomic , copy) NSString              * deptMasterEmail;
@property (nonatomic , copy) NSString              * companyCode;

@property (nonatomic , copy) NSString              *deptCount;

@end
