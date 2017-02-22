//
//  HomeViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/21.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

#pragma mark private
-(void)h_initialize{
    
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findPersonShiftDetailResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findPersonShiftDetailResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[AttendWorkShiftDetail class] rowRootName:@"AttendWorkShiftDetails"];
        self.arr = arr;
        
        [self.resultSubject sendNext:nil];
  
    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}

-(RACSubject *)resultSubject{
    if (!_resultSubject) {
        _resultSubject = [RACSubject subject];
    }
    return _resultSubject;
}

-(RACSubject *)headclickSubject{
    if (!_headclickSubject) {
        _headclickSubject = [RACSubject subject];
    }
    return _headclickSubject;
}

-(RACSubject *)setClickSubject{
    if (!_setClickSubject) {
        _setClickSubject = [RACSubject subject];
    }
    return _setClickSubject;
}

#pragma mark lazyload
-(RACCommand *)sendclickCommand{
    if (!_sendclickCommand) {
        
        _sendclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSString *body1 =[NSString stringWithFormat: @"<findEmpByUserCode xmlns=\"http://service.webservice.vada.com/\">\
                                  <companyCode xmlns=\"\">%@</companyCode>\
                                  <userCode xmlns=\"\">%@</userCode>\
                                  </findEmpByUserCode>",self.companyCode,self.userCode];
                
                [self SOAPData:findEmpByUserCode soapBody:body1 success:^(NSString *result) {
                    
                    NSDictionary *xmlDoc = [self getFilter:result filter:@"Emp"];
                    
                    EmpModel *empModel = [EmpModel mj_objectWithKeyValues:xmlDoc];
                    self.empModel = empModel;
                    
                    self.deptCode = empModel.deptCode;
                    self.empCode = empModel.empCode;
                    
                    [[NSUserDefaults standardUserDefaults] setObject:empModel.empTelphone forKey:@"empTelphone"];
                    /************************************************/
                    NSString *body2 =[NSString stringWithFormat: @"<findDeptByDeptCode xmlns=\"http://service.webservice.vada.com/\">\
                                      <companyCode xmlns=\"\">%@</companyCode>\
                                      <deptCode xmlns=\"\">%@</deptCode>\
                                      </findDeptByDeptCode>",self.companyCode,self.deptCode];
                    
                    [self SOAPData:findEmpByUserCode soapBody:body2 success:^(NSString *result) {
                        
                        
                        NSDictionary *xmlDoc = [self getFilter:result filter:@"Dept"];
                        
                        Dept *dept = [Dept mj_objectWithKeyValues:xmlDoc];
                        
                        self.dept = dept;
                        
                        /************************************************/
                        NSString *body3 =[NSString stringWithFormat: @"<findPersonShiftWorkPlan xmlns=\"http://service.webservice.vada.com/\">\
                                          <companyCode xmlns=\"\">%@</companyCode>\
                                          <empCode xmlns=\"\">%@</empCode>\
                                          <curYear xmlns=\"\">%@</curYear>\
                                          <curMonth xmlns=\"\">%@</curMonth>\
                                          <curDay xmlns=\"\">%@</curDay>\
                                          </findPersonShiftWorkPlan>",self.companyCode,self.empCode,self.curYear,self.curMonth,self.curDay];
                        
                        
                        [self SOAPData:findPersonShiftWorkPlan soapBody:body3 success:^(NSString *result) {
                            
                            
                            NSDictionary *xmlDoc = [self getFilter:result filter:@"AttendWorkShift"];
                            
                            AttendWorkShift *attendWorkShift = [AttendWorkShift mj_objectWithKeyValues:xmlDoc];
                            self.attendWorkShift = attendWorkShift;
                            
                            self.shiftLsh = attendWorkShift.shiftLsh;
                            
                            /*************************************/
                            NSString *body4 =[NSString stringWithFormat: @"<findPersonShiftDetail xmlns=\"http://service.webservice.vada.com/\">\
                                              <shiftLsh xmlns=\"\">%@</shiftLsh>\
                                              </findPersonShiftDetail>",self.shiftLsh];
                            
                            
                            [self SOAPData:findPersonShiftDetail soapBody:body4 success:^(NSString *result) {
                                
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
                    } failure:^(NSError *error) {
                        DismissHud();
                        ShowErrorStatus(@"请检查网络状态");
                    }];
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
        _arr = [NSMutableArray array] ;
    }
    return _arr;
}



@end
