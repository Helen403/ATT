//
//  LateTreatmentViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LateTreatmentViewModel.h"
#import "LateTreatmentModel.h"

@implementation LateTreatmentViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findApplyUnProcResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findApplyUnProcResponse>"];
        
        NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[LateTreatmentModel class] rowRootName:@"FlowCheckModels"];
     
        NSMutableArray *arr = [NSMutableArray array];
        NSInteger count = arrTmp.count;
        for(int i = 0;i<count;i++){
            LateTreatmentModel *lateTreatment = arrTmp[i];
            lateTreatment.empColor = randomColorA;
            [arr addObject:lateTreatment];
        }
        self.arr = arr;
        [self.tableViewSubject sendNext:nil];
        DismissHud();
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];

}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findApplyUnProc xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findApplyUnProc>",self.companyCode,self.userCode];
                
                [self SOAPData:findApplyUnProc soapBody:body success:^(NSString *result) {
                    
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
    return _refreshDataCommand;
}

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject] ;
    }
    return _tableViewSubject;
}


-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}


@end
