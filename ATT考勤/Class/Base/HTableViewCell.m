//
//  HTableViewCell.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HTableViewCell.h"

@implementation HTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self h_setupViews];
        [self h_bindViewModel];
    }
    return self;
}

- (void)h_setupViews{}

- (void)h_bindViewModel{}


-(NSInteger)h_w:(NSInteger)width{
    return autoScaleW(width);
}

@end
