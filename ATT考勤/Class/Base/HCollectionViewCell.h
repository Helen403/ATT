//
//  HCollectionViewCell.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCollerctionViewCellProtocol.h"

@interface HCollectionViewCell : UICollectionViewCell<HCollerctionViewCellProtocol>

-(NSInteger)h_w:(NSInteger)width;

@end
