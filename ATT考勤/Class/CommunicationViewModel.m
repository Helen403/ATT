//
//  CommunicationViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/4/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CommunicationViewModel.h"
#import "CommunicationModel.h"

@implementation CommunicationViewModel


#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findMyEmpFriendsResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findMyEmpFriendsResponse>"];
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[CommunicationModel class] rowRootName:@"Emps"];
        self.arr = arr;
        
        [self.tableViewSubject sendNext:nil];
        
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    [self.delCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [LSCoreToolCenter getFilterStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"删除成功");
        }else{
            ShowErrorStatus(@"删除失败");
        }
      
        
    }];

}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
}

-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}

-(RACSubject *)myTeamSubject{
    if (!_myTeamSubject) {
        _myTeamSubject = [RACSubject subject] ;
    }
    return _myTeamSubject;
}

-(RACSubject *)searchSubject{
    if (!_searchSubject) {
        _searchSubject = [RACSubject subject] ;
    }
    return _searchSubject;
}


-(RACSubject *)myCompanySubject{
    if (!_myCompanySubject) {
        _myCompanySubject = [RACSubject subject] ;
    }
    return _myCompanySubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                NSString *body =[NSString stringWithFormat: @"<findMyEmpFriends xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <myEmpCode xmlns=\"\">%@</myEmpCode>\
                                 </findMyEmpFriends>",self.companyCode,
                                 self.myEmpCode];
                
                [self SOAPData:findMyEmpFriends soapBody:body success:^(NSString *result) {
                    
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

- (RACCommand *)delCommand {
    
    if (!_delCommand) {
        
        @weakify(self);
        _delCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                NSString *body =[NSString stringWithFormat: @"<delMyEmpFriends xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <myEmpCode xmlns=\"\">%@</myEmpCode>\
                                  <friendEmpCode xmlns=\"\">%@</friendEmpCode>\
                                 </delMyEmpFriends>",self.companyCode,
                                 self.myEmpCode,self.friendEmpCode];
                
                [self SOAPData:delMyEmpFriends soapBody:body success:^(NSString *result) {
                    
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
    return _delCommand;
}




@end
