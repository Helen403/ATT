//
//  ChoiceStaffViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChoiceStaffTeamViewModel.h"
#import "TeamModel.h"
#import "TeamListModel.h"


@implementation ChoiceStaffTeamViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc1 = [self getFilterStr:result filter1:@"<ns2:findAllDeptByCompanyCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllDeptByCompanyCodeResponse>"];
        
        NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc1 class:[TeamModel class] rowRootName:@"Depts"];
        if (arrTmp.count>0) {
            self.arr = arrTmp;
            self.arrTmp = arrTmp;
            [self.tableViewSubject sendNext:nil];
            self.index  = 0;
            [self.CrefreshDataCommand execute:nil];
        }
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    [self.CrefreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            NSMutableArray *arr = [NSMutableArray array];
            for(int i = 0;i<self.arrTmp.count;i++){
                TeamModel *teamModel = self.arrTmp[i];
                if (self.index==i) {
                    teamModel.deptCount = @"0";
                }
                [arr addObject:teamModel];
            }
            self.arrTmp = arr;
        }else{
            
            NSString *xmlDoc2 = [self getFilterStr:result filter1:@"<ns2:findAllEmpByCompanyDeptCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllEmpByCompanyDeptCodeResponse>"];
            NSMutableArray *arrT = [LSCoreToolCenter xmlToArray:xmlDoc2 class:[TeamListModel class] rowRootName:@"Emps"];
            NSMutableArray *arr = [NSMutableArray array];
            
            for(int i = 0;i<self.arrTmp.count;i++){
                TeamModel *teamModel = self.arrTmp[i];
                if (self.index==i) {
                    teamModel.deptCount = [NSString stringWithFormat:@"%lu",(unsigned long)arrT.count];
                }
                [arr addObject:teamModel];
            }
            self.arrTmp = arr;
        }
        _CrefreshDataCommand = nil;
        [self h_initialize];
        self.index++;
        if (self.index == self.arr.count) {
            self.arr = self.arrTmp;
            [self.tableViewSubject sendNext:nil];
            return;
        }else{
            [self.CrefreshDataCommand execute:nil];
        }
        
    }];
    
}


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body1 =[NSString stringWithFormat: @"<findAllDeptByCompanyCode xmlns=\"http://service.webservice.vada.com/\">\
                                  <companyCode xmlns=\"\">%@</companyCode>\
                                  </findAllDeptByCompanyCode>",self.companyCode];
                
                [self SOAPData:findAllDeptByCompanyCode soapBody:body1 success:^(NSString *result1) {
                    
                    [subscriber sendNext:result1];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}

- (RACCommand *)CrefreshDataCommand {
    
    if (!_CrefreshDataCommand) {
        
        @weakify(self);
        _CrefreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                TeamModel *team = self.arrTmp[self.index];
                NSString *body2 =[NSString stringWithFormat: @"<findAllEmpByCompanyDeptCode xmlns=\"http://service.webservice.vada.com/\">\
                                  <companyCode xmlns=\"\">%@</companyCode>\
                                  <deptCode xmlns=\"\">%@</deptCode>\
                                  </findAllEmpByCompanyDeptCode>",team.companyCode,team.deptCode];
                
                [self SOAPData:findAllEmpByCompanyDeptCode soapBody:body2 success:^(NSString *result2) {
                    
                    [subscriber sendNext:result2];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    DismissHud();
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
        }];
    }
    
    return _CrefreshDataCommand;
}


-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
    
}


@end
