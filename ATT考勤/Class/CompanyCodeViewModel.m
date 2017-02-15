//
//  CompanyCodeViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CompanyCodeViewModel.h"
#import "Company.h"

@implementation CompanyCodeViewModel

#pragma mark private
-(void)h_initialize{
    
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {

        DismissHud();

        [self.addclickSubject sendNext:nil];
    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];

}

-(RACSubject *)addclickSubject{
    if (!_addclickSubject) {
        _addclickSubject = [RACSubject subject];
    }
    return _addclickSubject;

}

#pragma mark lazyload
-(RACCommand *)sendclickCommand{
    if (!_sendclickCommand) {
        
        _sendclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findCompanyByInviteCode xmlns=\"http://service.webservice.vada.com/\">\
                                 <inviteCode xmlns=\"\">%@</inviteCode>\
                                </findCompanyByInviteCode>",self.companyCode];

                [self SOAPData:Find_Company_info soapBody:body success:^(NSString *result) {
                    

                    NSDictionary *xmlDoc = [self getFilter:result filter:@"Company"];
                    
                    Company *model = [Company mj_objectWithKeyValues:xmlDoc];
                    self.companyCode = model.companyCode;
                    
                    /***********************************************/
                    NSString *body2 =[NSString stringWithFormat: @"<saveUserCompany xmlns=\"http://service.webservice.vada.com/\">\
                                     <userCode xmlns=\"\">%@</userCode>\
                                     <companyCode xmlns=\"\">%@</companyCode>\
                                     </saveUserCompany>",self.userCode,self.companyCode];

                    [self SOAPData:add_Company soapBody:body2 success:^(NSString *result) {
                        
                        [subscriber sendNext:result];
                        [subscriber sendCompleted];
                    } failure:^(NSError *error) {
                        [self toast:@"请检查网络状态"];
                        DismissHud();
                    }];
                    
                    
                } failure:^(NSError *error) {
                    [self toast:@"请检查网络状态"];
                    DismissHud();
                }];
                return nil;
            }];
        }];
        
    }
    return _sendclickCommand;
}


@end
