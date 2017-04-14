//
//  MySchedulieViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MySchedulieViewModel.h"
#import "MySchedulieModel.h"
#import "MySchedulieShiftWork.h"

@implementation MySchedulieViewModel


#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAllShiftWorkPlanResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllShiftWorkPlanResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[MySchedulieShiftWork class] rowRootName:@"AttendWorkPlans"];
        self.shiftWorkArr = arr;
        
        [self.successSubject sendNext:nil];
    }];

}

-(NSMutableArray *)shiftWorkArr{
    if (!_shiftWorkArr) {
        _shiftWorkArr = [NSMutableArray array];
    }
    return _shiftWorkArr;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                ShowMaskStatus(@"正在拼命加载");
                NSString *body1 =[NSString stringWithFormat: @"<findAllHolidayByMonth xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <curYear xmlns=\"\">%@</curYear>\
                                 <curMonth xmlns=\"\">%@</curMonth>\
                                 </findAllHolidayByMonth>",self.companyCode,self.curYear,self.curMonth];
                
                [self SOAPData:findAllHolidayByMonth soapBody:body1 success:^(NSString *result1) {
                    if ([result1 isEqualToString:@"netFail"]||[result1 isEqualToString:@""]) {
                        return ;
                    }
                    NSString *xmlDoc = [self getFilterStr:result1 filter1:@"<ns2:findAllHolidayByMonthResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllHolidayByMonthResponse>"];
                    
                    NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[MySchedulieModel class] rowRootName:@"AttendHolidays"];
                    self.holidayArr = arr;
                    
                    NSString *body2 =[NSString stringWithFormat: @"<findAllShiftWorkPlan xmlns=\"http://service.webservice.vada.com/\">\
                                     <companyCode xmlns=\"\">%@</companyCode>\
                                      <empCode xmlns=\"\">%@</empCode>\
                                     <curYear xmlns=\"\">%@</curYear>\
                                     <curMonth xmlns=\"\">%@</curMonth>\
                                     </findAllShiftWorkPlan>",self.companyCode,self.empCode,self.curYear,self.curMonth];
                    
                    [self SOAPData:findAllShiftWorkPlan soapBody:body2 success:^(NSString *result) {
                        
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
    return _refreshDataCommand;
}

-(RACSubject *)successSubject{
    if (!_successSubject) {
        _successSubject = [RACSubject subject];
    }
    return _successSubject;
}


@end
