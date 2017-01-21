//
//  ChatModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject
//0为自己  1为别人
@property(nonatomic,strong) NSString *judge;

@property(nonatomic,strong) NSString *img;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *content;

@end
