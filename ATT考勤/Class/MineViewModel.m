//
//  MineViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MineViewModel.h"
#import "MineModel.h"
#import "UserModel.h"

@implementation MineViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        DismissHud();
        if (result.length<200) {
            
            [self.failSubject sendNext:nil];
        }else{
            
            NSDictionary *xmlDoc = [self getFilter:result filter:@"User"];
            
            UserModel *model = [UserModel mj_objectWithKeyValues:xmlDoc];
            
            //存储对象
            saveModel(model, @"user");
            
            [self.successSubject sendNext:nil];
        }
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.findSignCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
           DismissHud();
        NSLog(@"%lu",(unsigned long)result.length);
        if (result.length<189) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"signName"];
        }else{
            NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
            [[NSUserDefaults standardUserDefaults] setObject:xmlDoc forKey:@"signName"];
            [self.successSignSubject sendNext:nil];
        }

    }];
    
    
    [[[self.findSignCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Mine" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [MineModel mj_objectArrayWithKeyValuesArray:data];
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
                
                NSString *body =[NSString stringWithFormat: @"<findUserByTelphone xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </findUserByTelphone>",self.telphone];
                
                [self SOAPData:findUserByTelphone soapBody:body success:^(NSString *result) {
                    
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

-(RACSubject *)successSubject{
    if (!_successSubject) {
        _successSubject = [RACSubject subject] ;
    }
    return _successSubject;
}


-(RACSubject *)failSubject{
    if (!_failSubject) {
        _failSubject = [RACSubject subject] ;
    }
    return _failSubject;
}

-(RACSubject *)successSignSubject{
    if (!_successSignSubject) {
        _successSignSubject = [RACSubject subject] ;
    }
    return _successSignSubject;
}

- (RACCommand *)findSignCommand {
    
    if (!_findSignCommand) {
        
        @weakify(self);
        _findSignCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findUserSignName xmlns=\"http://service.webservice.vada.com/\">\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findUserSignName>",self.userCode];
                
                [self SOAPData:findUserSignName soapBody:body success:^(NSString *result) {
                    
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
    
    return _findSignCommand;
}


@end
