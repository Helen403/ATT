//
//  HViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@implementation HViewModel
//@synthesize request  = _request;

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

//- (CMRequest *)request {
//    
//    if (!_request) {
//        
//        _request = [CMRequest request];
//    }
//    return _request;
//}

- (void)h_initialize {}


//SOAP请求
-(void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure {
    
    NSString *soapStr = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                         <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\
                         xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                         >\
                         <soap:Body>%@</soap:Body>\
                         </soap:Envelope>",soapBody];
    
    //    NSString *soapStr = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
    <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" >\
    <soap:Body>\
    <findUserByUserTelphone xmlns=\"http://service.security.vada.com/\">\
    <userTelphone xmlns=\"\">18666159484</userTelphone>\
    </findUserByUserTelphone>\
    </soap:Body>\
    </soap:Envelope>";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 访问方式
    [request setHTTPMethod:@"POST"];
    
    // body内容
    [request setHTTPBody:[soapStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",result);
        success(result);
        
        // NSLog(@"进入成功回调Session-----结果：%@----请求地址：%@", result, response.URL);
        if (error) {
            //            NSLog(@"Session----失败----%@", error.localizedDescription);
            failure(error);
        }
    }];
    
    [task resume];
    
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //
    //    // 设置请求超时时间
    //    manager.requestSerializer.timeoutInterval = 30;
    //
    //    // 返回NSData
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //
    //    // 设置请求头，也可以不设置
    //        [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%zd", soapStr.length] forHTTPHeaderField:@"Content-Length"];
    //
    //    // 设置HTTPBody
    //    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
    //        return soapStr;
    //    }];
    //
    //        [manager POST:url parameters:soapStr constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //
    //
    //        } progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //            // 把返回的二进制数据转为字符串
    //            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    //            success(result);
    //
    //        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //            if (failure) {
    //                failure(error);
    //            }
    //        }];
    
    
}


//Toast
-(void)toast:(NSString *)text{
    [Toast showWithText:text bottomOffset:60];
}

-(NSDictionary *)getFilter:(NSString *)result filter:(NSString *)filter{
    
    NSString *str1 = [NSString stringWithFormat:@"<%@>",filter];
    NSRange range1 = [result rangeOfString:str1];//匹配得到的下标
    NSString *str2 = [NSString stringWithFormat:@"</%@>",filter];
    NSRange range2 = [result rangeOfString:str2];//匹配得到的下标
    
    result = [result substringToIndex:range2.location+range2.length];
    result = [result substringFromIndex:range1.location];
    
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:result];
    
    return xmlDoc;
}

-(NSString *)getFilterStr:(NSString *)result filter:(NSString *)filter{
    
    NSString *str1 = [NSString stringWithFormat:@"<%@>",filter];
    NSRange range1 = [result rangeOfString:str1];//匹配得到的下标
    NSString *str2 = [NSString stringWithFormat:@"</%@>",filter];
    NSRange range2 = [result rangeOfString:str2];//匹配得到的下标
    
    result = [result substringToIndex:range2.location];
    result = [result substringFromIndex:range1.location+range1.length];
    return result;
}


-(NSString *)getFilterOneStr:(NSString *)result filter:(NSString *)filter{
    NSString *str1 = [NSString stringWithFormat:@"<%@>",filter];
    NSRange range1 = [result rangeOfString:str1];//匹配得到的下标
    NSString *str2 = [NSString stringWithFormat:@"</%@>",filter];
    NSRange range2 = [result rangeOfString:str2];//匹配得到的下标
    
    result = [result substringToIndex:range2.location];
    result = [result substringFromIndex:range1.location+range1.length];

    return result;
}

-(NSString *)getFilterStr:(NSString *)result filter1:(NSString *)filter1 filter2:(NSString *)filter2{
    
    NSRange range1 = [result rangeOfString:filter1];//匹配得到的下标
    NSRange range2 = [result rangeOfString:filter2];//匹配得到的下标
    
    result = [result substringToIndex:range2.location];
    result = [result substringFromIndex:range1.location+range1.length];
    return result;
}


-(NSDictionary *)getFilter:(NSString *)result filter1:(NSString *)filter1 filter2:(NSString *)filter2{
    
  
    NSRange range1 = [result rangeOfString:filter1];//匹配得到的下标
    NSRange range2 = [result rangeOfString:filter2];//匹配得到的下标
    
    result = [result substringToIndex:range2.location];
    result = [result substringFromIndex:range1.location+range1.length];
    
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:result];
    
    return xmlDoc;
}


@end
