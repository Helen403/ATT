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
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
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
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<189) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"signName"];
        }else{
            NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
            [[NSUserDefaults standardUserDefaults] setObject:xmlDoc forKey:@"signName"];
            [self.successSignSubject sendNext:nil];
        }

    }];
    
    
 
    
    [self.cardScoreCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<189) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cardScore"];
        }else{
            NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
            [[NSUserDefaults standardUserDefaults] setObject:xmlDoc forKey:@"cardScore"];
            [self.successSignSubject sendNext:nil];
        }
        
    }];
    
    
  
    [self.myHoldaysCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<189) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"findMyHoldays"];
        }else{
            NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
            [[NSUserDefaults standardUserDefaults] setObject:xmlDoc forKey:@"findMyHoldays"];
            [self.successSignSubject sendNext:nil];
        }
        
    }];
    

    [self.updataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
       // NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        
        //[self.fileSubject sendNext:nil];
        [self.modifyMyImageCommand execute:nil];
    }];
    
    [self.modifyMyImageCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        // NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        
        [self.fileSubject sendNext:nil];
        
    }];
    
    [self.findImageCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
         NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        [[NSUserDefaults standardUserDefaults] setObject:xmlDoc forKey:@"imgIcon"];
        [self.imgSubject sendNext:nil];
        
    }];
    
}

-(RACSubject *)fileSubject{
    if (!_fileSubject) {
        _fileSubject = [RACSubject subject] ;
    }
    return _fileSubject;
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
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}

- (RACCommand *)modifyMyImageCommand {
    
    if (!_modifyMyImageCommand) {
        
        @weakify(self);
        _modifyMyImageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<modifyMyImage xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <imagePath xmlns=\"\">%@</imagePath>\
                                 </modifyMyImage>",self.companyCode,self.userCode,self.imagePath];
                
                [self SOAPData:modifyMyImage soapBody:body success:^(NSString *result) {
                    
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
    
    return _modifyMyImageCommand;
}


- (RACCommand *)findImageCommand {
    
    if (!_findImageCommand) {
        
        @weakify(self);
        _findImageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findMyImage xmlns=\"http://service.webservice.vada.com/\">\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findMyImage>",self.userCode];
                
                [self SOAPData:findMyImage soapBody:body success:^(NSString *result) {
                    
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
    
    return _findImageCommand;
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
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
        }];
    }
    
    return _findSignCommand;
}

- (RACCommand *)cardScoreCommand {
    
    if (!_cardScoreCommand) {
        
        @weakify(self);
        _cardScoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findMyCardScore xmlns=\"http://service.webservice.vada.com/\">\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findMyCardScore>",self.userCode];
                
                [self SOAPData:findMyCardScore soapBody:body success:^(NSString *result) {
                    
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
    
    return _cardScoreCommand;
}

- (RACCommand *)myHoldaysCommand {
    
    if (!_myHoldaysCommand) {
        
        @weakify(self);
        _myHoldaysCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findMyHoldays xmlns=\"http://service.webservice.vada.com/\">\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findMyHoldays>",self.userCode];
                
                [self SOAPData:findMyHoldays soapBody:body success:^(NSString *result) {
                    
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
    
    return _myHoldaysCommand;
}


- (RACCommand *)updataCommand {
    
    if (!_updataCommand) {
        
        @weakify(self);
        _updataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<uploadFile xmlns=\"http://service.webservice.vada.com/\">\
                                 <fileName xmlns=\"\">%@</fileName>\
                                 <content xmlns=\"\">%@</content>\
                                 <fileType xmlns=\"\">%@</fileType>\
                                 </uploadFile>",self.fileName,self.content,self.fileType];
                
                [self SOAPData:findMyMsg soapBody:body success:^(NSString *result) {
                    
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
    return _updataCommand;
}

-(RACSubject *)imgSubject{
    if (!_imgSubject) {
        _imgSubject = [RACSubject subject];
    }
    return _imgSubject;
}


@end
