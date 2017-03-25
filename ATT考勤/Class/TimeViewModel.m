//
//  TimeViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeViewModel.h"
#import "TimeModel.h"

@implementation TimeViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        [self.tableViewSubject sendNext:nil];
        
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.modifyCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        
    }];
    
    [[[self.modifyCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
}


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Time" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [TimeModel mj_objectArrayWithKeyValuesArray:data];
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
                
                NSString *body1 =[NSString stringWithFormat: @"<findIsCardSound xmlns=\"http://service.webservice.vada.com/\">\
                                  <userCode xmlns=\"\">%@</userCode>\
                                  </findIsCardSound>",self.userCode];
                
                [self SOAPData:findIsCardSound soapBody:body1 success:^(NSString *result1) {
                    
                    NSString *xmlDoc1 = [self getFilterOneStr:result1 filter:@"String"];
                    
                    if ([xmlDoc1 isEqualToString:@"0"]) {
                        [[NSUserDefaults standardUserDefaults] setObject:xmlDoc1 forKey:@"findIsCardSound"];
                    }else{
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsCardSound"];
                    }
                    
                    NSString *body2 =[NSString stringWithFormat: @"<findIsCardVarient xmlns=\"http://service.webservice.vada.com/\">\
                                      <userCode xmlns=\"\">%@</userCode>\
                                      </findIsCardVarient>",self.userCode];
                    
                    [self SOAPData:findIsCardVarient soapBody:body2 success:^(NSString *result2) {
                        
                        NSString *xmlDoc2 = [self getFilterOneStr:result2 filter:@"String"];
                        
                        if ([xmlDoc2 isEqualToString:@"0"]) {
                            [[NSUserDefaults standardUserDefaults] setObject:xmlDoc2 forKey:@"findIsCardVarient"];
                        }else{
                            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsCardVarient"];
                        }
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



#pragma mark lazyload
-(RACCommand *)modifyCommand{
    if (!_modifyCommand) {
        
        _modifyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *cardSound =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsCardSound"];
                
                NSString *body1 =[NSString stringWithFormat: @"<modifyIsCardSound xmlns=\"http://service.webservice.vada.com/\">\
                                  <userCode xmlns=\"\">%@</userCode>\
                                  <isCardSound xmlns=\"\">%@</isCardSound>\
                                  </modifyIsCardSound>",self.userCode,cardSound];
                
                [self SOAPData:modifyIsCardSound soapBody:body1 success:^(NSString *result) {
                    
                    NSString *cardVarient =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsCardVarient"];
                    
                    NSString *body2 =[NSString stringWithFormat: @"<modifyIsCardVarient xmlns=\"http://service.webservice.vada.com/\">\
                                      <userCode xmlns=\"\">%@</userCode>\
                                      <isCardVarient xmlns=\"\">%@</isCardVarient>\
                                      </modifyIsCardVarient>",self.userCode,cardVarient];
                    
                    [self SOAPData:modifyIsCardVarient soapBody:body2 success:^(NSString *result) {
                        
                        [subscriber sendNext:result];
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
    return _modifyCommand;
}

@end
