//
//  FeedbackModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/13.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedbackModel : NSObject

@property (nonatomic , copy) NSString              * suggQuestion;
@property (nonatomic , copy) NSString              * suggTelphone;
@property (nonatomic , copy) NSString              * suggDatetime;
@property (nonatomic , copy) NSString              * suggId;
@property (nonatomic , copy) NSString              * suggTypeId;
@property (nonatomic , copy) NSString              * suggUserCode;
@property (nonatomic , copy) NSString              * companyCode;

@end
