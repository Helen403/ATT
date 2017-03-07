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

//消息 公告数量,输入[用户编号,公司编号],输出[公告数量]
#define findAnnounceNumber @"http://192.168.1.101:8888/smart/ws/IAttService"
//消息 通知数量,输入[用户编号,公司编号],输出[通知数量]
#define findNoticeNumber @"http://192.168.1.101:8888/smart/ws/IAttService"

//消息 消息数量,输入[用户编号,公司编号],输出[消息数量]
#define findNewsNumber @"http://192.168.1.101:8888/smart/ws/IAttService"

//消息 公告查询,输入[用户编号,公司编号],输出[分页公告]
#define findAllAnnounce @"http://192.168.1.101:8888/smart/ws/IAttService"

//消息 通知查询,输入[用户编号,公司编号],输出[分页通知]
#define findAllNotices @"http://192.168.1.101:8888/smart/ws/IAttService"

//个人信息 修改我的昵称
#define modifyUserNickName @"http://192.168.1.101:8888/smart/ws/IAttService"

//个人信息  获取我的签名
#define findUserSignName @"http://192.168.1.101:8888/smart/ws/IAttService"

//个人信息 修改我的签名
#define modifyUserSignName @"http://192.168.1.101:8888/smart/ws/IAttService"

//个人信息 查找我的积分
#define findMyCardScore @"http://192.168.1.101:8888/smart/ws/IAttService"

//个人信息 查找我的假期
#define findMyHoldays @"http://192.168.1.101:8888/smart/ws/IAttService"

//请假类型
#define findAttendOffWorkType @"http://192.168.1.101:8888/smart/ws/IAttService"

//加班类型
#define findAttendOverTimeTypeWork @"http://192.168.1.101:8888/smart/ws/IAttService"
//加班补偿方式
#define findAttendOverTimeWorkType @"http://192.168.1.101:8888/smart/ws/IAttService"

//加班提交
#define saveApplyOverTime @"http://192.168.1.101:8888/smart/ws/IAttService"

//出差类型
#define findAttendOffWorkType @"http://192.168.1.101:8888/smart/ws/IAttService"

//出差提交
#define saveApplyOutWork @"http://192.168.1.101:8888/smart/ws/IAttService"

//外出类型
#define findAttendGoOutWork @"http://192.168.1.101:8888/smart/ws/IAttService"

//外出提交
#define saveApplyGoOutWork @"http://192.168.1.101:8888/smart/ws/IAttService"

//班次查询
#define findAttendWorkShift @"http://192.168.1.101:8888/smart/ws/IAttService"

//换班提交
#define saveApplyChangeWork @"http://192.168.1.101:8888/smart/ws/IAttService"

//调班申请提交
#define saveApplySwapWork @"http://192.168.1.101:8888/smart/ws/IAttService"

//辞职类型
#define findAttendLeaveType @"http://192.168.1.101:8888/smart/ws/IAttService"

//辞职申请提交
#define saveApplyLeave @"http://192.168.1.101:8888/smart/ws/IAttService"

//调休类型
#define findAttendPaintLeaveType @"http://192.168.1.101:8888/smart/ws/IAttService"

//调休申请
#define saveApplyPaintLeave @"http://192.168.1.101:8888/smart/ws/IAttService"

//漏打卡提交
#define saveApplyForget @"http://192.168.1.101:8888/smart/ws/IAttService"

//迟到提交
#define saveApplyLate @"http://192.168.1.101:8888/smart/ws/IAttService"

//早退提交
#define saveApplyEarly @"http://192.168.1.101:8888/smart/ws/IAttService"

//花费类型
#define findAttendCostType @"http://192.168.1.101:8888/smart/ws/IAttService"

//花费提交
#define saveApplyCost @"http://192.168.1.101:8888/smart/ws/IAttService"
