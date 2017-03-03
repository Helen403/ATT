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
#define findUserByTelphone @"http://www.attonline.com.cn:8080/smart/ws/IAttService"
//忘记密码－发送验证码 输入[手机号码],输出[发送验证码]
#define sendValidateSMS @"http://www.attonline.com.cn:8080/smart/ws/IAttService"
//忘记密码－修改密码  修改密码,输入[手机号码,新密码],输出[]
#define modifyUserPwd @"http://www.attonline.com.cn:8080/smart/ws/IAttService"
//获取公司列表
#define MultiRoles_getCompanyList @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//创建账户1-发送验证吗 输入[手机号码],输出[发送验证码]
#define sendValidateSMS @"http://www.attonline.com.cn:8080/smart/ws/IAttService"
//创建账户2-注册账户  保存帐号,输入[手机号码,用户名,密码],输出[用户编号]
#define saveUser @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//加入公司－根据邀请码查询公司信息
#define findCompanyByInviteCode @"http://www.attonline.com.cn:8080/smart/ws/IAttService"
//加入公司  保存用户角色, 输入[用户编号,公司邀请码] ,输出[]
#define  saveUserCompany @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//加入公司 用户变员工
#define saveUserToEmp @"http://www.attonline.com.cn:8080/smart/ws/IAttService"


//通讯录-查询员工信息, 输入[公司编号],输出[员工信息]
#define findAllEmpByCompanyCode @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//通讯录-查询员工信息, 输入[公司编号],输出[员工信息]
#define  findAllDeptByCompanyCode  @"http://www.attonline.com.cn:8080/smart/ws/IAttService"
//通讯录 查询员工信息, 输入[姓名,手机号,公司编号],输出[员工信息]
#define findEmpByNameOrTelPhone @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//通讯录 查询员工信息, 输入[员工编号],输出[员工信息]
#define findEmpByCode @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//通讯录 查询员工信息, 输入[公司编号,部门编号],输出[员工信息]
#define findAllEmpByCompanyDeptCode @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//首页 根据用户号查询员工号
#define findEmpByUserCode @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//首页 输出上班规则
#define findPersonShiftWorkPlan @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//首页 输出上班规则详情
#define findPersonShiftDetail @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//首页 打卡
#define saveAttendRecord @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//#=======================================================#

//系统设置
#define  modifyUserPwd @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//消息 公告数量,输入[用户编号,公司编号],输出[公告数量]
#define findAnnounceNumber @"http://www.attonline.com.cn:8080/smart/ws/IAttService"
//消息 通知数量,输入[用户编号,公司编号],输出[通知数量]
#define findNoticeNumber @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//消息 消息数量,输入[用户编号,公司编号],输出[消息数量]
#define findNewsNumber @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//消息 公告查询,输入[用户编号,公司编号],输出[分页公告]
#define findAllAnnounce @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//消息 通知查询,输入[用户编号,公司编号],输出[分页通知]
#define findAllNotices @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//个人信息 修改我的昵称
#define modifyUserNickName @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//个人信息  获取我的签名
#define findUserSignName @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//个人信息 修改我的签名
#define modifyUserSignName @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//个人信息 查找我的积分
#define findMyCardScore @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//个人信息 查找我的假期
#define findMyHoldays @"http://www.attonline.com.cn:8080/smart/ws/IAttService"


//请假类型
#define findAttendOffWorkType @"http://www.attonline.com.cn:8080/smart/ws/IAttService"

//加班类型
#define findAttendOverTimeTypeWork @"http://www.attonline.com.cn:8080/smart/ws/IAttService"
//加班补偿方式
#define findAttendOverTimeWorkType @"http://www.attonline.com.cn:8080/smart/ws/IAttService"


