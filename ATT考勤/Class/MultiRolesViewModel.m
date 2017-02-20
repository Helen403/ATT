//
//  MultiRolesViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MultiRolesViewModel.h"
#import "MultiRolesModel.h"

@implementation MultiRolesViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findCompanyListByUserCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findCompanyListByUserCodeResponse>"];
//        NSLog(@"%@",result);

        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[MultiRolesModel class] rowRootName:@"Companys"];
        self.arr = arr;

        [self.backSubject sendNext:xmlDoc];
        
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
    }
    return _arr;
}

-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}

-(RACSubject *)addSubject{
    
    if (!_addSubject) {
        _addSubject = [RACSubject subject];
    }
    return _addSubject;
}



-(RACSubject *)backSubject{
    if (!_backSubject) {
        _backSubject = [RACSubject subject];
    }
    return _backSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findCompanyListByUserCode xmlns=\"http://service.webservice.vada.com/\">\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findCompanyListByUserCode>",self.userCode];
                
                [self SOAPData:MultiRoles_getCompanyList soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
              
                     ShowErrorStatus(@"请检查网络状态");
                    DismissHud();
                }];
                
                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}


@end
