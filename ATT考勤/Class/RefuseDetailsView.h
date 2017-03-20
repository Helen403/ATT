//
//  RefuseDetailsView.h
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HView.h"

@interface RefuseDetailsView : HView

@property(nonatomic,assign) NSInteger indexTmp;

-(void)refreash:(NSInteger)indexTmp;


@end
