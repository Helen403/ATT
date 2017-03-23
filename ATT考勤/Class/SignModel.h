//
//  SignModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignModel : NSObject

@property (nonatomic , copy) NSString              * empName;
@property (nonatomic , copy) NSString              * empSort;
@property (nonatomic , copy) NSString              * empSex;
@property (nonatomic , copy) NSString              * cardDatetime;

@property(nonatomic,strong) UIColor * empColor;
@end
