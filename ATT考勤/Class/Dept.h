//
//  Dept.h
//  ATT考勤
//
//  Created by Helen on 17/2/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dept : NSObject

@property (nonatomic , copy) NSString              * deptFullName;
@property (nonatomic , copy) NSString              * deptParentCode;
@property (nonatomic , copy) NSString              * deptMasterName;
@property (nonatomic , copy) NSString              * deptMasterTel;
@property (nonatomic , copy) NSString              * deptCode;
@property (nonatomic , copy) NSString              * deptNickName;
@property (nonatomic , copy) NSString              * deptStatus;
@property (nonatomic , copy) NSString              * deptMasterEmail;
@property (nonatomic , copy) NSString              * companyCode;

@end
