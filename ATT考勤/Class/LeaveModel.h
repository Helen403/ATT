//
//  LeaveModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaveModel : NSObject

//@property(nonatomic,strong) NSString *title;


@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * isPayBase;
@property (nonatomic , copy) NSString              * workLsh;
@property (nonatomic , copy) NSString              * isPaySec;
@property (nonatomic , copy) NSString              * companyCode;
@property (nonatomic , copy) NSString              * addBonus;
@property (nonatomic , copy) NSString              * addSalary;
@property (nonatomic , copy) NSString              * subSalary;
@property (nonatomic , copy) NSString              * subBonus;
@property (nonatomic , copy) NSString              * workName;

@end
