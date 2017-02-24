//
//  APIMacro.h
//  PeachNet
//
//  Created by 牛哲 on 15/6/16.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

/**
 *  本文件可放请求API 拼接的路径
 */

// *********************************************************
//登陆  登陆APP, 输入[手机号码],输出[用户信息]
#define findUserByTelphone @"http://192.168.1.101:8888/smart/ws/IAttService"
//忘记密码－发送验证码 输入[手机号码],输出[发送验证码]
#define sendValidateSMS @"http://192.168.1.101:8888/smart/ws/IAttService"
//忘记密码－修改密码  修改密码,输入[手机号码,新密码],输出[]
#define modifyUserPwd @"http://192.168.1.101:8888/smart/ws/IAttService"
//获取公司列表
#define MultiRoles_getCompanyList @"http://192.168.1.101:8888/smart/ws/IAttService"

//创建账户1-发送验证吗 输入[手机号码],输出[发送验证码]
#define sendValidateSMS @"http://192.168.1.101:8888/smart/ws/IAttService"
//创建账户2-注册账户  保存帐号,输入[手机号码,用户名,密码],输出[用户编号]
#define saveUser @"http://192.168.1.101:8888/smart/ws/IAttService"

//加入公司－根据邀请码查询公司信息
#define findCompanyByInviteCode @"http://192.168.1.101:8888/smart/ws/IAttService"
//加入公司  保存用户角色, 输入[用户编号,公司邀请码] ,输出[]
#define  saveUserCompany @"http://192.168.1.101:8888/smart/ws/IAttService"

//加入公司 用户变员工
#define saveUserToEmp @"http://192.168.1.101:8888/smart/ws/IAttService"


//通讯录-查询员工信息, 输入[公司编号],输出[员工信息]
#define findAllEmpByCompanyCode @"http://192.168.1.101:8888/smart/ws/IAttService"

//通讯录-查询员工信息, 输入[公司编号],输出[员工信息]
#define  findAllDeptByCompanyCode  @"http://192.168.1.101:8888/smart/ws/IAttService"
//通讯录 查询员工信息, 输入[姓名,手机号,公司编号],输出[员工信息]
#define findEmpByNameOrTelPhone @"http://192.168.1.101:8888/smart/ws/IAttService"

//通讯录 查询员工信息, 输入[员工编号],输出[员工信息]
#define findEmpByCode @"http://192.168.1.101:8888/smart/ws/IAttService"

//通讯录 查询员工信息, 输入[公司编号,部门编号],输出[员工信息]
#define findAllEmpByCompanyDeptCode @"http://192.168.1.101:8888/smart/ws/IAttService"

//首页 根据用户号查询员工号
#define findEmpByUserCode @"http://192.168.1.101:8888/smart/ws/IAttService"

//首页 输出上班规则
#define findPersonShiftWorkPlan @"http://192.168.1.101:8888/smart/ws/IAttService"

//首页 输出上班规则详情
#define findPersonShiftDetail @"http://192.168.1.101:8888/smart/ws/IAttService"

//首页 打卡
#define saveAttendRecord @"http://192.168.1.101:8888/smart/ws/IAttService"

//#=======================================================#

//系统设置
#define  modifyUserPwd @"http://192.168.1.101:8888/smart/ws/IAttService"
