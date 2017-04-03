//
//  LYWCollectionViewCell.h
//  ATT考勤
//
//  Created by Helen on 17/3/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriangleView.h"

@interface LYWCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *dateLable;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) TriangleView *triangleView;

- (instancetype)initWithFrame:(CGRect)frame;

@end
