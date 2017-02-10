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
#import "Toast.h"

@interface HViewModel : NSObject <HViewModelProtocol>

//SOAP请求
-(void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

//Toast
-(void)toast:(NSString *)text;


-(NSDictionary *)getFilter:(NSString *)result filter:(NSString *)filter;

-(NSString *)getFilterStr:(NSString *)result filter:(NSString *)filter;

-(NSString *)getFilterStr:(NSString *)result filter1:(NSString *)filter1 filter2:(NSString *)filter2;

-(NSDictionary *)getFilter:(NSString *)result filter1:(NSString *)filter1 filter2:(NSString *)filter2;

-(NSString *)getFilterOneStr:(NSString *)result filter:(NSString *)filter;

@end
