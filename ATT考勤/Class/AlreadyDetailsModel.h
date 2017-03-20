//
//  AlreadyDetailsModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlreadyDetailsModel : NSObject

@property (nonatomic , copy) NSString              * reason;
@property (nonatomic , copy) NSString              * endDate;
@property (nonatomic , copy) NSString              * startDate;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * type1Name;
@property (nonatomic , copy) NSString              * type2Name;
@property (nonatomic , copy) NSString              * flowInstanceId;

@end
