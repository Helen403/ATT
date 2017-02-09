//
//  CMRequest.m
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/21.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import "CMRequest.h"

@implementation CMRequest

+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.operationManager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)(CMRequest *, NSString *))success
    failure:(void (^)(CMRequest *, NSError *))failure {
    
    self.operationQueue=self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [self.operationManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"[CMRequest]: %@",responseJson);
        success(self,responseJson);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSLog(@"[CMRequest]: %@",error.localizedDescription);
        failure(self,error);
    }];
    
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(CMRequest *request, NSString* responseString))success
     failure:(void (^)(CMRequest *request, NSError *error))failure{
    
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    [self.operationManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
//        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString* responseJson = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"[CMRequest]: %@",responseJson);
        success(self,responseJson);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSLog(@"[CMRequest]: %@",error.localizedDescription);
        failure(self,error);

    }];
    
}

- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters {
    
    [self POST:URLString
    parameters:parameters
       success:^(CMRequest *request, NSString *responseString) {
           if ([self.delegate respondsToSelector:@selector(CMRequest:finished:)]) {
               [self.delegate CMRequest:request finished:responseString];
               
           }
       }
       failure:^(CMRequest *request, NSError *error) {
           if ([self.delegate respondsToSelector:@selector(CMRequest:Error:)]) {
               [self.delegate CMRequest:request Error:error.description];
           }
       }];
}

- (void)getWithURL:(NSString *)URLString {
    
    [self GET:URLString parameters:nil success:^(CMRequest *request, NSString *responseString) {
        if ([self.delegate respondsToSelector:@selector(CMRequest:finished:)]) {
            [self.delegate CMRequest:request finished:responseString];
        }
    } failure:^(CMRequest *request, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(CMRequest:Error:)]) {
            [self.delegate CMRequest:request Error:error.description];
        }
    }];
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}


//SOAP请求
-(void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody targetNamespace:(NSString *)TargetNamespace  success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure {
    
//    NSString *soapStr = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
//                         <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\
//                         xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
//                         xmlns:xnl=\"%@\">\
//                         <soap:Header>\
//                         </soap:Header>\
//                         <soap:Body>%@</soap:Body>\
//                         </soap:Envelope>",TargetNamespace,soapBody];
    
    NSString *soapStr = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
    <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\
    <soap:Body>\
    <findUserByTelphone xmlns=\"http://service.webservice.vada.com/\">\
    <telphone xmlns=\"\">13549880208</telphone>\
    </findUserByTelphone>\
    </soap:Body>\
    </soap:Envelope>";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    // 返回NSData
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置请求头，也可以不设置
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%zd", soapStr.length] forHTTPHeaderField:@"Content-Length"];
    
    // 设置HTTPBody
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapStr;
    }];
    
    [manager POST:url parameters:soapStr constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 把返回的二进制数据转为字符串
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    //    [manager POST:url parameters:soapStr success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
    //
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //    }];
}


@end
