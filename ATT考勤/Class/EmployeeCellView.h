//
//  EmployeeCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "EmployeeModel.h"

@interface EmployeeCellView : HTableViewCell

@property(nonatomic,strong) EmployeeModel *employeeModel;

@end
