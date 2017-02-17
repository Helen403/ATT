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
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAllEmpByCompanyCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllEmpByCompanyCodeResponse>"];
//                NSLog(@"%@",result);
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[AddressListModel class] rowRootName:@"Emps"];
        self.arr = arr;
        
        [self.tableViewSubject sendNext:xmlDoc];
        
        DismissHud();
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
//        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"AddressList" ofType:@"plist"];
//        
//        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
//        
//        _arr= [AddressListModel mj_objectArrayWithKeyValuesArray:data];
        
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
                
                [self SOAPData:findAllEmpByCompanyCode soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [self toast:@"请检查网络状态"];
                    DismissHud();
                }];
                
                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}


@end
