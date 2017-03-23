//
//  SignViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SignViewModel.h"
#import "SignModel.h"

@implementation SignViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findSortEmpSignResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findSortEmpSignResponse>"];
        
        NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[SignModel class] rowRootName:@"CardSignDayModels"];
        NSMutableArray *arr = [NSMutableArray array];
        NSInteger count = arrTmp.count;
        for(int i = 0;i<count;i++){
            SignModel *sign = arrTmp[i];
            sign.empColor = randomColorA;
            [arr addObject:sign];
        }
        self.arr = arr;
        [self.successSubject sendNext:nil];
        
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
                
                NSString *body =[NSString stringWithFormat: @"<findSortEmpSign xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                   <cardDate xmlns=\"\">%@</cardDate>\
                                 </findSortEmpSign>",self.companyCode,self.cardDate];
                
                [self SOAPData:findSortEmpSign soapBody:body success:^(NSString *result) {
                    
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

-(RACSubject *)successSubject{
    if (!_successSubject) {
        _successSubject = [RACSubject subject];
    }
    return _successSubject;
}


-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}


@end
