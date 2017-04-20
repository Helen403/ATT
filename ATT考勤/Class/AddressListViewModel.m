//
//  AddressListViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AddressListViewModel.h"
#import "AddressListModel.h"

@implementation AddressListViewModel


#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAllEmpByCompanyCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllEmpByCompanyCodeResponse>"];
        
        NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[AddressListModel class] rowRootName:@"Emps"];
     
        self.arr = arrTmp;
        
        [self.tableViewSubject sendNext:nil];
        if (self.arr>0) {
            [[EGOCache globalCache] setString:result forKey:@"findAllEmpByCompanyCode"];
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

-(RACSubject *)teamclickSubject{
    if (!_teamclickSubject) {
        _teamclickSubject = [RACSubject subject];
    }
    return _teamclickSubject;
}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
    
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findAllEmpByCompanyCode xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 </findAllEmpByCompanyCode>",self.companyCode];
                
               NSString *findAll =  [[EGOCache globalCache] stringForKey:@"findAllEmpByCompanyCode"];
                
                NSString *xmlDoc = [self getFilterStr:findAll filter1:@"<ns2:findAllEmpByCompanyCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllEmpByCompanyCodeResponse>"];
                
                NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[AddressListModel class] rowRootName:@"Emps"];
        
                if (arrTmp.count>0) {
                    [subscriber sendNext:findAll];
                    [subscriber sendCompleted];
                }else{
                    [self SOAPData:findAllEmpByCompanyCode soapBody:body success:^(NSString *result) {
                        
                        [subscriber sendNext:result];
                        [subscriber sendCompleted];
                    } failure:^(NSError *error) {
                        DismissHud();
                        ShowErrorStatus(@"请检查网络状态");
                        [subscriber sendNext:@"netFail"];
                        [subscriber sendCompleted];
                    }];
                }

                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}


@end
