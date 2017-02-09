//
//  HViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HViewModelProtocol.h"
#import "XMLDictionary.h"

@interface HViewModel : NSObject <HViewModelProtocol>

//SOAP请求
-(void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

@end
