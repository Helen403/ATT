//
//  CopyDetailsViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CopyDetailsViewModel.h"
#import "FlowStepChecksModel.h"
#import "CopyToMeModel.h"


@implementation CopyDetailsViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findFlowStepCheckByIdResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findFlowStepCheckByIdResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[FlowStepChecksModel class] rowRootName:@"FlowStepChecks"];
        
        self.arr = arr;
        [self.tableViewSubject sendNext:nil];
        
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
    }];
    
}


- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                CopyToMeModel *alreadyTreatmentModel = self.lateArr[self.indexTmp];
                self.applyType = alreadyTreatmentModel.applyType;
                self.applyLsh = alreadyTreatmentModel.applyLsh;
                
                
                NSString *body1 =[NSString stringWithFormat: @"<findFormByApplyId xmlns=\"http://service.webservice.vada.com/\">\
                                  <companyCode xmlns=\"\">%@</companyCode>\
                                  <applyType xmlns=\"\">%@</applyType>\
                                  <applyLsh xmlns=\"\">%@</applyLsh>\
                                  </findFormByApplyId>",self.companyCode,self.applyType,self.applyLsh];
                
                [self SOAPData:findFormByApplyId soapBody:body1 success:^(NSString *result1) {
                    NSDictionary *xmlDoc1 = [self getFilter:result1 filter:@"ApplyForms"];
                    
                    CopyDetailsModel *toDetailModel = [CopyDetailsModel mj_objectWithKeyValues:xmlDoc1];
                    self.toDetailModel = toDetailModel;
                    NSString *body2 =[NSString stringWithFormat: @"<findFlowStepCheckById xmlns=\"http://service.webservice.vada.com/\">\
                                      <companyCode xmlns=\"\">%@</companyCode>\
                                      <flowInstanceId xmlns=\"\">%@</flowInstanceId>\
                                      </findFlowStepCheckById>",self.companyCode,toDetailModel.flowInstanceId];
                    
                    [self SOAPData:findFlowStepCheckById soapBody:body2 success:^(NSString *result2) {
                        
                        [subscriber sendNext:result2];
                        [subscriber sendCompleted];
                    } failure:^(NSError *error) {
                        DismissHud();
                        ShowErrorStatus(@"请检查网络状态");
                        [subscriber sendNext:@"netFail"];
                        [subscriber sendCompleted];
                    }];
                    
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


-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject] ;
    }
    return _tableViewSubject;
}
@end
