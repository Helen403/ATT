//
//  HView.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HViewProtocol.h"

@interface HView : UIView <HViewProtocol>

-(NSInteger)h_w:(NSInteger)width;


@end
