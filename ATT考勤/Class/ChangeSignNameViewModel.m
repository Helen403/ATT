//
//  ChangeSignNameViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangeSignNameViewModel.h"
#import "GDataXMLNode.h"
@implementation ChangeSignNameViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:result options:0 error:nil];
        GDataXMLElement *xmlEle = [xmlDoc rootElement];
        NSArray *array = [xmlEle children];
        
        GDataXMLElement *ele = [array objectAtIndex:0];
        NSArray *array2 =[ele children];
        
        GDataXMLElement *ele2 = [array2 objectAtIndex:0];
        NSArray *array3 =[ele2 children];
        GDataXMLElement *ele3 = [array3 objectAtIndex:0];
        
        if ([[ele3 stringValue] isEqualToString:@"0"]) {
            ShowMessage(@"修改成功");
            [self.successSubject sendNext:nil];
              [[NSUserDefaults standardUserDefaults] setObject:self.userSignName forKey:@"signName"];
            
        }else{
            ShowMessage(@"修改失败");
            [self.failSubject sendNext:nil];
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
                
                NSString *body =[NSString stringWithFormat: @"<modifyUserSignName xmlns=\"http://service.webservice.vada.com/\">\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <userSignName xmlns=\"\">%@</userSignName>\
                                 </modifyUserSignName>",self.userCode,self.userSignName];
                
                [self SOAPData:modifyUserSignName soapBody:body success:^(NSString *result) {
                    
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
@end
