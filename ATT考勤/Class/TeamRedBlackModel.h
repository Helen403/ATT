//
//  TeamRedBlackModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamRedBlackModel : NSObject

@property (nonatomic , copy) NSString              * earlyLateWorkCount;
@property (nonatomic , copy) NSString              * deptName;
@property (nonatomic , copy) NSString              * deptSort;
@property (nonatomic , copy) NSString              * sumScore;
@property (nonatomic , copy) NSString              * normalCount;
@property (nonatomic , copy) NSString              * overWorkCount;
@property (nonatomic , copy) NSString              * otherWorkCount;

@end
