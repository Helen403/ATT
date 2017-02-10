//
//  MultiRolesModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiRolesModel : NSObject

@property(nonatomic,strong) NSString *img;

//@property(nonatomic,strong) NSString *title;


@property (nonatomic , copy) NSString              * companyIndustryType;
@property (nonatomic , copy) NSString              * companyOfAreaProv;
@property (nonatomic , copy) NSString              * companyNickName;
@property (nonatomic , copy) NSString              * companyPostCode;
@property (nonatomic , copy) NSString              * companyFullName;
@property (nonatomic , copy) NSString              * companyStatus;
@property (nonatomic , copy) NSString              * companyInvitationCode;
@property (nonatomic , copy) NSString              * registUserTelphone;
@property (nonatomic , copy) NSString              * registUserCode;
@property (nonatomic , copy) NSString              * companyAddress;
@property (nonatomic , copy) NSString              * companyOfAreaCity;
@property (nonatomic , copy) NSString              * registDatetime;
@property (nonatomic , copy) NSString              * companyCode;
@property (nonatomic , copy) NSString              * expireDatetime;

@end
