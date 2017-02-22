//
//  CompanyCodeViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CompanyCodeViewModel.h"
#import "Company.h"
#import "TeamModel.h"

@implementation CompanyCodeViewModel

#pragma mark private
-(void)h_initialize{
    
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        DismissHud();
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAllDeptByCompanyCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllDeptByCompanyCodeResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[TeamModel class] rowRootName:@"Depts"];
        self.arr = arr;
        
        [self.showClickSubject sendNext:result];
    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    [self.addTeamCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        DismissHud();
        
        //        if ([result isEqualToString:@"0"]) {
        [self.addclickSubject sendNext:nil];
        //        }
    }];
    
    [[[self.addTeamCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
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

-(RACSubject *)showClickSubject{
    if (!_showClickSubject) {
        _showClickSubject = [RACSubject subject];
    }
    return _showClickSubject;
}

-(RACSubject *)failclickSubject{
    if (!_failclickSubject) {
        _failclickSubject = [RACSubject subject];
    }
    return _failclickSubject;
}

#pragma mark lazyload
-(RACCommand *)sendclickCommand{
    if (!_sendclickCommand) {
        
        _sendclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findCompanyByInviteCode xmlns=\"http://service.webservice.vada.com/\">\
                                 <inviteCode xmlns=\"\">%@</inviteCode>\
                                 </findCompanyByInviteCode>",self.invitationCode];
                
                [self SOAPData:findCompanyByInviteCode soapBody:body success:^(NSString *result) {

                    if (result.length < 200) {
                        [self.failclickSubject sendNext:nil];
                        [subscriber sendCompleted];
                        
                    }else{
                        
                        NSDictionary *xmlDoc = [self getFilter:result filter:@"Company"];
                        
                        Company *model = [Company mj_objectWithKeyValues:xmlDoc];
                        
                        self.companyCode = model.companyCode;
                        /***********************************************/
                        NSString *body2 =[NSString stringWithFormat: @"<saveUserCompany xmlns=\"http://service.webservice.vada.com/\">\
                                          <userCode xmlns=\"\">%@</userCode>\
                                          <companyCode xmlns=\"\">%@</companyCode>\
                                          </saveUserCompany>",self.userCode,model.companyCode];
                        
                        [self SOAPData:saveUserCompany soapBody:body2 success:^(NSString *result) {
                            
                            
                            NSString *body3 =[NSString stringWithFormat: @"<findAllDeptByCompanyCode xmlns=\"http://service.webservice.vada.com/\">\
                                              <companyCode xmlns=\"\">%@</companyCode>\
                                              </findAllDeptByCompanyCode>",model.companyCode];
                            
                            [self SOAPData:findAllDeptByCompanyCode soapBody:body3 success:^(NSString *result) {
                                
                                [subscriber sendNext:result];
                                [subscriber sendCompleted];
                                
                            } failure:^(NSError *error) {
                                DismissHud();
                                ShowErrorStatus(@"请检查网络状态");
                                
                            }];
                            
                            
                        } failure:^(NSError *error) {
                            DismissHud();
                            ShowErrorStatus(@"请检查网络状态");
                            
                        }];
                    }
                    
                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                    
                }];
                return nil;
            }];
        }];
        
    }
    return _sendclickCommand;
}

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}


#pragma mark lazyload
-(RACCommand *)addTeamCommand{
    if (!_addTeamCommand) {
        
        _addTeamCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<saveUserToEmp xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <deptCode xmlns=\"\">%@</deptCode>\
                                 </saveUserToEmp>",self.companyCode,self.userCode,self.deptCode];
                
                [self SOAPData:saveUserToEmp soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                    
                }];
                return nil;
            }];
        }];
        
    }
    return _addTeamCommand;
}


@end
