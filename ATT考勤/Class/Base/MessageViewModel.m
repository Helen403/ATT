//
//  MessageViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MessageViewModel.h"
#import "MessageModel.h"

@implementation MessageViewModel


#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
         DismissHud();
   
        [self.tableViewSubject sendNext:nil];

    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];

    
    [self.modifyCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        DismissHud();
        
        
    }];
    
    [[[self.modifyCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
}


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Message" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [MessageModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arr;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body1 =[NSString stringWithFormat: @"<findIsReceAnnounce xmlns=\"http://service.webservice.vada.com/\">\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findIsReceAnnounce>",self.userCode];
                
                [self SOAPData:findIsReceAnnounce soapBody:body1 success:^(NSString *result1) {
      
                    NSString *xmlDoc1 = [self getFilterOneStr:result1 filter:@"String"];
                   
                    if ([xmlDoc1 isEqualToString:@"0"]) {
                        [[NSUserDefaults standardUserDefaults] setObject:xmlDoc1 forKey:@"findIsReceAnnounce"];
                    }else{
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsReceAnnounce"];
                    }
                    
                    NSString *body2 =[NSString stringWithFormat: @"<findIsReceNotice xmlns=\"http://service.webservice.vada.com/\">\
                                      <userCode xmlns=\"\">%@</userCode>\
                                      </findIsReceNotice>",self.userCode];
                    
                    [self SOAPData:findIsReceNotice soapBody:body2 success:^(NSString *result2) {
                        
                        
                        NSString *xmlDoc2 = [self getFilterOneStr:result2 filter:@"String"];
                        
                        if ([xmlDoc2 isEqualToString:@"0"]) {
                            [[NSUserDefaults standardUserDefaults] setObject:xmlDoc2 forKey:@"findIsReceNotice"];
                        }else{
                            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsReceNotice"];
                        }
                        
                        
                        NSString *body3 =[NSString stringWithFormat: @"<findIsReceNews xmlns=\"http://service.webservice.vada.com/\">\
                                          <userCode xmlns=\"\">%@</userCode>\
                                          </findIsReceNews>",self.userCode];
                        
                        [self SOAPData:findIsReceNews soapBody:body3 success:^(NSString *result3) {
                            
                            
                            NSString *xmlDoc3 = [self getFilterOneStr:result3 filter:@"String"];
                            
                            if ([xmlDoc3 isEqualToString:@"0"]) {
                                [[NSUserDefaults standardUserDefaults] setObject:xmlDoc3 forKey:@"findIsReceNews"];
                            }else{
                                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsReceNews"];
                            }
                            [subscriber sendNext:result3];
                            [subscriber sendCompleted];
                        } failure:^(NSError *error) {
                            DismissHud();
                            ShowErrorStatus(@"请检查网络状态");
                        }];

                     
                    } failure:^(NSError *error) {
                        DismissHud();
                        ShowErrorStatus(@"请检查网络状态");
                    }];

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


-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}


#pragma mark lazyload
-(RACCommand *)modifyCommand{
    if (!_modifyCommand) {
        
        _modifyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
               
                NSString *announce =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsReceAnnounce"];
                
                NSString *body1 =[NSString stringWithFormat: @"<modifyIsReceAnnounce xmlns=\"http://service.webservice.vada.com/\">\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <isReceAnnounce xmlns=\"\">%@</isReceAnnounce>\
                                 </modifyIsReceAnnounce>",self.userCode,announce];
                
                [self SOAPData:modifyIsReceAnnounce soapBody:body1 success:^(NSString *result) {
                    
                    NSString *notice =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsReceNotice"];
                    
                    NSString *body2 =[NSString stringWithFormat: @"<modifyIsReceNotice xmlns=\"http://service.webservice.vada.com/\">\
                                     <userCode xmlns=\"\">%@</userCode>\
                                     <isReceNotice xmlns=\"\">%@</isReceNotice>\
                                     </modifyIsReceNotice>",self.userCode,notice];
                    
                    [self SOAPData:modifyIsReceNotice soapBody:body2 success:^(NSString *result) {
                        
                        NSString *news =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsReceNews"];
                        
                        NSString *body3 =[NSString stringWithFormat: @"<modifyIsReceNews xmlns=\"http://service.webservice.vada.com/\">\
                                          <userCode xmlns=\"\">%@</userCode>\
                                          <isReceNews xmlns=\"\">%@</isReceNews>\
                                          </modifyIsReceNews>",self.userCode,news];
                        
                        [self SOAPData:modifyIsReceNews soapBody:body3 success:^(NSString *result) {
                            
                            [subscriber sendNext:result];
                            [subscriber sendCompleted];
                        } failure:^(NSError *error) {
                            DismissHud();
                            ShowErrorStatus(@"请检查网络状态");
                        }];
                    } failure:^(NSError *error) {
                        DismissHud();
                        ShowErrorStatus(@"请检查网络状态");
                    }];

                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                    
                }];
                return nil;
            }];
        }];
        
    }
    return _modifyCommand;
}



@end
