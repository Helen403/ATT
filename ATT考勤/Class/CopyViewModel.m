//
//  CopyViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CopyViewModel.h"
#import "CopyToMeModel.h"

@implementation CopyViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<200) {
            ShowMessage(@"没有更多数据");
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findApplyCopysTomeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findApplyCopysTomeResponse>"];
            
            NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[CopyToMeModel class] rowRootName:@"FlowCheckModels"];
            
            NSMutableArray *arr = [NSMutableArray array];
            NSInteger count = arrTmp.count;
            for(int i = 0;i<count;i++){
                CopyToMeModel *refuseModel = arrTmp[i];
                refuseModel.empColor = randomColorA;
                [arr addObject:refuseModel];
            }
            self.arr = arr;
            [self.tableViewSubject sendNext:nil];
        }
        
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
                
                NSString *body =[NSString stringWithFormat: @"<findApplyCopysTome xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findApplyCopysTome>",self.companyCode,self.userCode];
                
                [self SOAPData:findApplyCopysTome soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
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
