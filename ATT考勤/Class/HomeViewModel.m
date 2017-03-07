//
//  HomeViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/21.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HomeViewModel.h"
#import "GDataXMLNode.h"
#import "AttendCardRecord.h"

@implementation HomeViewModel



#pragma mark private
-(void)h_initialize{
    
    [self.findAttendRecordByUserDateCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        
        if (result.length<200) {
              NSNumber *row =[NSNumber numberWithInteger:2];
            [self.attendFailSubject sendNext:row];
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendRecordByUserDateResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendRecordByUserDateResponse>"];
            
            NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[AttendCardRecord class] rowRootName:@"AttendCardRecords"];
            self.arrAttendRecord = arr;
            NSNumber *row =[NSNumber numberWithInteger:1];
            [self.attendRecordSubject sendNext:row];
        }

    }];
    
    
    [[[self.findAttendRecordByUserDateCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
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
    
    
    [self.attendRecordCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:result options:0 error:nil];
        GDataXMLElement *xmlEle = [xmlDoc rootElement];
        NSArray *array = [xmlEle children];
        
        GDataXMLElement *ele = [array objectAtIndex:0];
        NSArray *array2 =[ele children];
        
        GDataXMLElement *ele2 = [array2 objectAtIndex:0];
        NSArray *array3 =[ele2 children];
        GDataXMLElement *ele3 = [array3 objectAtIndex:0];
        
        if ([[ele3 stringValue] isEqualToString:@"0"]) {
            [self.attendRecordSuccessSubject sendNext:nil];
            ShowMessage(@"打卡成功");
        }else{
            if([[ele3 stringValue] isEqualToString:@"2"]){
                ShowMessage(@"已经打过卡");
                [self.attendRecordFailSubject sendNext:nil];
            }else{
                [self.attendRecordFailSubject sendNext:nil];
                ShowErrorStatus(@"打卡失败");
            }
        }
        
    }];
    
    
    [[[self.attendRecordCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在打卡,请稍等");
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

-(RACSubject *)attendRecordSuccessSubject{
    if (!_attendRecordSuccessSubject) {
        _attendRecordSuccessSubject = [RACSubject subject];
    }
    return _attendRecordSuccessSubject;
}

-(RACSubject *)attendRecordFailSubject{
    if (!_attendRecordFailSubject) {
        _attendRecordFailSubject = [RACSubject subject];
    }
    return _attendRecordFailSubject;
}

-(RACSubject *)attendRecordSubject{
    if (!_attendRecordSubject) {
        _attendRecordSubject = [RACSubject subject];
    }
    return _attendRecordSubject;
}

-(RACSubject *)attendFailSubject{
    if (!_attendFailSubject) {
        _attendFailSubject = [RACSubject subject];
    }
    return _attendFailSubject;
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
                            
                            if (result.length<250) {
                                
                                ShowMessage(@"请通知管理员没有工作安排");
                                [subscriber sendCompleted];
                            }else{
                                
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
                            }
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


#pragma mark lazyload
-(RACCommand *)findAttendRecordByUserDateCommand{
    if (!_findAttendRecordByUserDateCommand) {
        
        _findAttendRecordByUserDateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSString *body1 =[NSString stringWithFormat: @"<findAttendRecordByUserDate xmlns=\"http://service.webservice.vada.com/\">\
                                  <companyCode xmlns=\"\">%@</companyCode>\
                                  <userCode xmlns=\"\">%@</userCode>\
                                  <cardDate xmlns=\"\">%@</cardDate>\
                                  <timePhase xmlns=\"\">%@</timePhase>\
                                  </findAttendRecordByUserDate>",self.companyCode,self.userCode,self.cardDate,self.timePhase];
                
                [self SOAPData:findEmpByUserCode soapBody:body1 success:^(NSString *result) {
                    
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
    return _findAttendRecordByUserDateCommand;
}


-(NSMutableArray *)arrAttendRecord{
    if (!_arrAttendRecord) {
        _arrAttendRecord = [NSMutableArray array] ;
    }
    return _arrAttendRecord;
}

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array] ;
    }
    return _arr;
}


#pragma mark lazyload
-(RACCommand *)attendRecordCommand{
    if (!_attendRecordCommand) {
        
        _attendRecordCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<saveAttendRecord xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <cardDate xmlns=\"\">%@</cardDate>\
                                 <cardTime xmlns=\"\">%@</cardTime>\
                                 <cardDeviceType xmlns=\"\">%@</cardDeviceType>\
                                 <cardDeviceName xmlns=\"\">%@</cardDeviceName>\
                                 <empCode xmlns=\"\">%@</empCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <userName xmlns=\"\">%@</userName>\
                                 <deptCode xmlns=\"\">%@</deptCode>\
                                 <deptName xmlns=\"\">%@</deptName>\
                                 <locLongitude xmlns=\"\">%@</locLongitude>\
                                 <locLatitude xmlns=\"\">%@</locLatitude>\
                                 <locAddress xmlns=\"\">%@</locAddress>\
                                 <clockMode xmlns=\"\">%@</clockMode>\
                                 <timePhase xmlns=\"\">%@</timePhase>\
                                 <timePoint xmlns=\"\">%@</timePoint>\
                                 <cardStatus xmlns=\"\">%@</cardStatus>\
                                 </saveAttendRecord>",self.companyCode,self.cardDate,self.cardTime,self.cardDeviceType,self.cardDeviceName,self.empCode,self.userCode,self.userName,self.deptCode,self.deptName,self.locLongitude,self.locLatitude,self.locAddress,self.clockMode,self.timePhase,self.timePoint,self.cardStatus];
                
                [self SOAPData:saveAttendRecord soapBody:body success:^(NSString *result) {
                    
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
    return _attendRecordCommand;
}

@end
