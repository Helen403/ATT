//
//  MyExamineViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyExamineViewModel.h"
#import "MyExamineModel.h"
#import "LateTreatmentModel.h"
#import "AlreadyTreatmentModel.h"
#import "RefuseModel.h"
#import "CopyToMeModel.h"

@implementation MyExamineViewModel

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"myexamine" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        for (NSDictionary *dict in data) {
            // 3.1.创建模型对象
            
            MyExamineModel *myExamine = [MyExamineModel examineWithDict:dict];
            // 3.2.添加模型对象到数组中
            [_arr addObject:myExamine];
        }
    }
    return _arr;
}

-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}

#pragma mark private
-(void)h_initialize{
    
    [self.LrefreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<188) {
            
        }else{
            
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findApplyUnProcResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findApplyUnProcResponse>"];
            
            NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[LateTreatmentModel class] rowRootName:@"FlowCheckModels"];
            NSMutableArray *arr = [NSMutableArray array];
            NSInteger count = self.arr.count;
            for(int i = 0;i<count;i++){
                MyExamineModel *myExamine= self.arr[i];
                if (i==0) {
                    myExamine.hint = [NSString stringWithFormat:@"%lu",(unsigned long)arrTmp.count];
                }
                [arr addObject:myExamine];
            }
            self.arr = arr;
            [self.tableViewSubject sendNext:nil];
        }
    }];
    
    
    [self.ArefreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<200) {
            
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findApplyAlreadyProcResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findApplyAlreadyProcResponse>"];
            
            NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[AlreadyTreatmentModel class] rowRootName:@"FlowCheckModels"];
            NSMutableArray *arr = [NSMutableArray array];
            NSInteger count = self.arr.count;
            for(int i = 0;i<count;i++){
                MyExamineModel *myExamine= self.arr[i];
                
                if (i==1) {
                    myExamine.hint = [NSString stringWithFormat:@"%lu",(unsigned long)arrTmp.count];
                }
                [arr addObject:myExamine];
            }
            self.arr = arr;
            [self.tableViewSubject sendNext:nil];
        }
        
    }];
    
    
    [self.RrefreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<200) {
            
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findApplyRefusedResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findApplyRefusedResponse>"];
            
            NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[RefuseModel class] rowRootName:@"FlowCheckModels"];
            NSMutableArray *arr = [NSMutableArray array];
            NSInteger count = self.arr.count;
            for(int i = 0;i<count;i++){
                MyExamineModel *myExamine= self.arr[i];
                
                if (i==2) {
                    myExamine.hint = [NSString stringWithFormat:@"%lu",(unsigned long)arrTmp.count];
                }
                [arr addObject:myExamine];
            }
            self.arr = arr;
            [self.tableViewSubject sendNext:nil];
        }
    }];
    
    [self.CrefreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<200) {
            
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findApplyCopysTomeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findApplyCopysTomeResponse>"];
            
            NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[CopyToMeModel class] rowRootName:@"FlowCheckModels"];
            NSMutableArray *arr = [NSMutableArray array];
            NSInteger count = self.arr.count;
            for(int i = 0;i<count;i++){
                MyExamineModel *myExamine= self.arr[i];

                if (i==3) {
                    myExamine.hint = [NSString stringWithFormat:@"%lu",(unsigned long)arrTmp.count];
                }
                [arr addObject:myExamine];
            }
            self.arr = arr;
            [self.tableViewSubject sendNext:nil];
        }
        
    }];
    
    
}

- (RACCommand *)LrefreshDataCommand {
    
    if (!_LrefreshDataCommand) {
        
        @weakify(self);
        _LrefreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
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
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _LrefreshDataCommand;

}



- (RACCommand *)ArefreshDataCommand {
    
    if (!_ArefreshDataCommand) {
        
        @weakify(self);
        _ArefreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findApplyAlreadyProc xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findApplyAlreadyProc>",self.companyCode,self.userCode];
                
                [self SOAPData:findApplyAlreadyProc soapBody:body success:^(NSString *result) {
                    
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
    return _ArefreshDataCommand;
}



- (RACCommand *)RrefreshDataCommand {
    
    if (!_RrefreshDataCommand) {
        
        @weakify(self);
        _RrefreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findApplyRefused xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findApplyRefused>",self.companyCode,self.userCode];
                
                [self SOAPData:findApplyRefused soapBody:body success:^(NSString *result) {
                    
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
    return _RrefreshDataCommand;
}

- (RACCommand *)CrefreshDataCommand {
    
    if (!_CrefreshDataCommand) {
        
        @weakify(self);
        _CrefreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
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
    return _CrefreshDataCommand;
}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject] ;
    }
    return _tableViewSubject;
}

@end
