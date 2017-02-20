//
//  ScanCodeModel.h
//  ATT考勤
//
//  Created by Helen on 17/2/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanCodeModel : NSObject
//{companyCode:3,companyInvitationCode:'ccc'}
@property(nonatomic,assign) NSString *companyCode;

@property(nonatomic,strong) NSString *companyInvitationCode;

@end
