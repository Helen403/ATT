//
//  HViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@implementation HViewModel


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    HViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel h_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)h_initialize {}


//SOAP请求
-(void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure {
    
    NSString *soapStr = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                         <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\
                         xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                         >\
                         <soap:Body>%@</soap:Body>\
                         </soap:Envelope>",soapBody];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 访问方式
    [request setHTTPMethod:@"POST"];
    
    // body内容
    [request setHTTPBody:[soapStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        success(result);
        if (error) {
            failure(error);
        }
    }];
    
    [task resume];

}

-(NSDictionary *)getFilter:(NSString *)result filter:(NSString *)filter{

    if(result.length==0){
        return nil;
    }
    
    NSString *str1 = [NSString stringWithFormat:@"<%@>",filter];
    NSRange range1 = [result rangeOfString:str1];//匹配得到的下标
    NSString *str2 = [NSString stringWithFormat:@"</%@>",filter];
    NSRange range2 = [result rangeOfString:str2];//匹配得到的下标
    NSDictionary *xmlDoc;
    
    @try {
        result = [result substringToIndex:range2.location+range2.length];
        result = [result substringFromIndex:range1.location];
        
        xmlDoc = [NSDictionary dictionaryWithXMLString:result];
    } @catch (NSException *exception) {
        xmlDoc = nil;
        ShowMessage(@"请检查网络");
    } @finally {
        
    }
    return xmlDoc;
}

-(NSString *)getFilterStr:(NSString *)result filter:(NSString *)filter{
    
    if(result.length==0){
        return @"";
    }
    NSString *str1 = [NSString stringWithFormat:@"<%@>",filter];
    NSRange range1 = [result rangeOfString:str1];//匹配得到的下标
    NSString *str2 = [NSString stringWithFormat:@"</%@>",filter];
    NSRange range2 = [result rangeOfString:str2];//匹配得到的下标

    @try {
        result = [result substringToIndex:range2.location];
        result = [result substringFromIndex:range1.location+range1.length];
    } @catch (NSException *exception) {
        result = @"";
        ShowMessage(@"请检查网络");
    } @finally {
        
    }
    return result;
}


-(NSString *)getFilterOneStr:(NSString *)result filter:(NSString *)filter{
    if(result.length==0){
        return @"";
    }
    NSString *str1 = [NSString stringWithFormat:@"<%@>",filter];
    NSRange range1 = [result rangeOfString:str1];//匹配得到的下标
    NSString *str2 = [NSString stringWithFormat:@"</%@>",filter];
    NSRange range2 = [result rangeOfString:str2];//匹配得到的下标
    
    @try {
        result = [result substringToIndex:range2.location];
        result = [result substringFromIndex:range1.location+range1.length];
    } @catch (NSException *exception) {
        result = @"";
        ShowMessage(@"请检查网络");
    } @finally {
        
    }
    return result;
}

-(NSString *)getFilterStr:(NSString *)result filter1:(NSString *)filter1 filter2:(NSString *)filter2{
    if(result.length==0){
        return @"";
    }
    
    NSRange range1 = [result rangeOfString:filter1];//匹配得到的下标
    NSRange range2 = [result rangeOfString:filter2];//匹配得到的下标
    @try {
        result = [result substringToIndex:range2.location];
        result = [result substringFromIndex:range1.location+range1.length];
    } @catch (NSException *exception) {
        result = @"";
        ShowMessage(@"请检查网络");
    } @finally {
        
    }
    return result;
}


-(NSDictionary *)getFilter:(NSString *)result filter1:(NSString *)filter1 filter2:(NSString *)filter2{
    
    if(result.length==0){
        ShowMessage(@"请检查网络");
        return nil;
    }
    NSDictionary *xmlDoc;
    NSRange range1 = [result rangeOfString:filter1];//匹配得到的下标
    NSRange range2 = [result rangeOfString:filter2];//匹配得到的下标
    @try {
        result = [result substringToIndex:range2.location];
        result = [result substringFromIndex:range1.location+range1.length];
        
        xmlDoc = [NSDictionary dictionaryWithXMLString:result];
    } @catch (NSException *exception) {
        xmlDoc = nil;
        ShowMessage(@"请检查网络");
    } @finally {
        
    }
    return xmlDoc;
}


@end
