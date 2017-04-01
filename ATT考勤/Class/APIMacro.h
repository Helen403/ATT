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
#define findUserByTelphone @"http://13822767713.xicp.net/smart/ws/IAttService"
//忘记密码－发送验证码 输入[手机号码],输出[发送验证码]
#define sendValidateSMS @"http://13822767713.xicp.net/smart/ws/IAttService"
//忘记密码－修改密码  修改密码,输入[手机号码,新密码],输出[]
#define modifyUserPwd @"http://13822767713.xicp.net/smart/ws/IAttService"
//获取公司列表
#define MultiRoles_getCompanyList @"http://13822767713.xicp.net/smart/ws/IAttService"

//创建账户1-发送验证吗 输入[手机号码],输出[发送验证码]
#define sendValidateSMS @"http://13822767713.xicp.net/smart/ws/IAttService"
//创建账户2-注册账户  保存帐号,输入[手机号码,用户名,密码],输出[用户编号]
#define saveUser @"http://13822767713.xicp.net/smart/ws/IAttService"

//加入公司－根据邀请码查询公司信息
#define findCompanyByInviteCode @"http://13822767713.xicp.net/smart/ws/IAttService"
//加入公司  保存用户角色, 输入[用户编号,公司邀请码] ,输出[]
#define  saveUserCompany @"http://13822767713.xicp.net/smart/ws/IAttService"

//加入公司 用户变员工
#define saveUserToEmp @"http://13822767713.xicp.net/smart/ws/IAttService"


//通讯录-查询员工信息, 输入[公司编号],输出[员工信息]
#define findAllEmpByCompanyCode @"http://13822767713.xicp.net/smart/ws/IAttService"

//通讯录-查询员工信息, 输入[公司编号],输出[员工信息]
#define  findAllDeptByCompanyCode  @"http://13822767713.xicp.net/smart/ws/IAttService"
//通讯录 查询员工信息, 输入[姓名,手机号,公司编号],输出[员工信息]
#define findEmpByNameOrTelPhone @"http://13822767713.xicp.net/smart/ws/IAttService"

//通讯录 查询员工信息, 输入[员工编号],输出[员工信息]
#define findEmpByCode @"http://13822767713.xicp.net/smart/ws/IAttService"

//通讯录 查询员工信息, 输入[公司编号,部门编号],输出[员工信息]
#define findAllEmpByCompanyDeptCode @"http://13822767713.xicp.net/smart/ws/IAttService"

//首页 根据用户号查询员工号
#define findEmpByUserCode @"http://13822767713.xicp.net/smart/ws/IAttService"

//首页 输出上班规则
#define findPersonShiftWorkPlan @"http://13822767713.xicp.net/smart/ws/IAttService"

//首页 输出上班规则详情
#define findPersonShiftDetail @"http://13822767713.xicp.net/smart/ws/IAttService"

//首页 打卡
#define saveAttendRecord @"http://13822767713.xicp.net/smart/ws/IAttService"

//#=======================================================#

//系统设置
#define  modifyUserPwd @"http://13822767713.xicp.net/smart/ws/IAttService"

//消息 公告数量,输入[用户编号,公司编号],输出[公告数量]
#define findAnnounceNumber @"http://13822767713.xicp.net/smart/ws/IAttService"
//消息 通知数量,输入[用户编号,公司编号],输出[通知数量]
#define findNoticeNumber @"http://13822767713.xicp.net/smart/ws/IAttService"

//消息 消息数量,输入[用户编号,公司编号],输出[消息数量]
#define findNewsNumber @"http://13822767713.xicp.net/smart/ws/IAttService"

//消息 公告查询,输入[用户编号,公司编号],输出[分页公告]
#define findAllAnnounce @"http://13822767713.xicp.net/smart/ws/IAttService"

//消息 通知查询,输入[用户编号,公司编号],输出[分页通知]
#define findAllNotices @"http://13822767713.xicp.net/smart/ws/IAttService"

//个人信息 修改我的昵称
#define modifyUserNickName @"http://13822767713.xicp.net/smart/ws/IAttService"

//个人信息  获取我的签名
#define findUserSignName @"http://13822767713.xicp.net/smart/ws/IAttService"

//个人信息 修改我的签名
#define modifyUserSignName @"http://13822767713.xicp.net/smart/ws/IAttService"

//个人信息 查找我的积分
#define findMyCardScore @"http://13822767713.xicp.net/smart/ws/IAttService"

//个人信息 查找我的假期
#define findMyHoldays @"http://13822767713.xicp.net/smart/ws/IAttService"

//请假类型
#define findAttendOffWorkType @"http://13822767713.xicp.net/smart/ws/IAttService"

//加班类型
#define findAttendOverTimeTypeWork @"http://13822767713.xicp.net/smart/ws/IAttService"
//加班补偿方式
#define findAttendOverTimeWorkType @"http://13822767713.xicp.net/smart/ws/IAttService"

//加班提交
#define saveApplyOverTime @"http://13822767713.xicp.net/smart/ws/IAttService"

//出差类型
#define findAttendOffWorkType @"http://13822767713.xicp.net/smart/ws/IAttService"

//出差提交
#define saveApplyOutWork @"http://13822767713.xicp.net/smart/ws/IAttService"

//外出类型
#define findAttendGoOutWork @"http://13822767713.xicp.net/smart/ws/IAttService"

//外出提交
#define saveApplyGoOutWork @"http://13822767713.xicp.net/smart/ws/IAttService"

//班次查询
#define findAttendWorkShift @"http://13822767713.xicp.net/smart/ws/IAttService"

//换班提交
#define saveApplyChangeWork @"http://13822767713.xicp.net/smart/ws/IAttService"

//调班申请提交
#define saveApplySwapWork @"http://13822767713.xicp.net/smart/ws/IAttService"

//辞职类型
#define findAttendLeaveType @"http://13822767713.xicp.net/smart/ws/IAttService"

//辞职申请提交
#define saveApplyLeave @"http://13822767713.xicp.net/smart/ws/IAttService"

//调休类型
#define findAttendPaintLeaveType @"http://13822767713.xicp.net/smart/ws/IAttService"

//调休申请
#define saveApplyPaintLeave @"http://13822767713.xicp.net/smart/ws/IAttService"

//漏打卡提交
#define saveApplyForget @"http://13822767713.xicp.net/smart/ws/IAttService"

//迟到提交
#define saveApplyLate @"http://13822767713.xicp.net/smart/ws/IAttService"

//早退提交
#define saveApplyEarly @"http://13822767713.xicp.net/smart/ws/IAttService"

//花费类型
#define findAttendCostType @"http://13822767713.xicp.net/smart/ws/IAttService"

//花费提交
#define saveApplyCost @"http://13822767713.xicp.net/smart/ws/IAttService"

//接收企业公告
#define findIsReceAnnounce @"http://13822767713.xicp.net/smart/ws/IAttService"

//修改企业公告
#define modifyIsReceAnnounce @"http://13822767713.xicp.net/smart/ws/IAttService"

//接收企业通知
#define findIsReceNotice @"http://13822767713.xicp.net/smart/ws/IAttService"

//修改企业通知
#define modifyIsReceNotice @"http://13822767713.xicp.net/smart/ws/IAttService"

//接收同事消息
#define findIsReceNews @"http://13822767713.xicp.net/smart/ws/IAttService"

//修改同事通知
#define modifyIsReceNews @"http://13822767713.xicp.net/smart/ws/IAttService"

//获取考勤轨迹
#define findAttendRecordByUserMonth @"http://13822767713.xicp.net/smart/ws/IAttService"

//获取所有意见反馈
#define findAllSuggbackByUser @"http://13822767713.xicp.net/smart/ws/IAttService"

//获取声音提示
#define findIsCardSound @"http://13822767713.xicp.net/smart/ws/IAttService"

//获取手机是否震动
#define findIsCardVarient @"http://13822767713.xicp.net/smart/ws/IAttService"

//修改声音提示
#define modifyIsCardSound @"http://13822767713.xicp.net/smart/ws/IAttService"

//修改手机震动
#define modifyIsCardVarient @"http://13822767713.xicp.net/smart/ws/IAttService"


//审批人模版
#define saveFlowTemplate @"http://13822767713.xicp.net/smart/ws/IAttService"

//待处理
#define findApplyUnProc @"http://13822767713.xicp.net/smart/ws/IAttService"

//通过审批
#define findFormByApplyId @"http://13822767713.xicp.net/smart/ws/IAttService"

//审批通过id
#define findFlowStepCheckById @"http://13822767713.xicp.net/smart/ws/IAttService"

//流程审批
#define updateCheckFlow @"http://13822767713.xicp.net/smart/ws/IAttService"

//已经审批
#define findApplyAlreadyProc @"http://13822767713.xicp.net/smart/ws/IAttService"

//已拒绝
#define findApplyRefused @"http://13822767713.xicp.net/smart/ws/IAttService"

//抄送我的
#define findApplyCopysTome @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤日报
#define findMyDayReport @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤日报详情
#define findMyDayReportDetail @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤周报
#define findMyWeekReport @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤周报详情
#define findMyWeekReportDetail @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤月报
#define findMyMonthReport @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤月报详情
#define findMyMonthReportDetail @"http://13822767713.xicp.net/smart/ws/IAttService"


//考勤部门日报
#define findDeptDayReport  @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤部门日报详情
#define findDeptDayReportDetail @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤部门周报
#define findDeptWeekReport @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤部门月报
#define findDeptMonthReport @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤部门外勤
#define findDeptOutReport @"http://13822767713.xicp.net/smart/ws/IAttService"

//考勤部门外勤详情
#define findDeptOutDetailReport @"http://13822767713.xicp.net/smart/ws/IAttService"

//英雄榜
#define findSortEmpHours @"http://13822767713.xicp.net/smart/ws/IAttService"

//签到英雄榜
#define findSortEmpSign @"http://13822767713.xicp.net/smart/ws/IAttService"

//红黑榜
#define findDeptRedBlack @"http://13822767713.xicp.net/smart/ws/IAttService"

//公告通知通过ID
#define findAnnounceById @"http://13822767713.xicp.net/smart/ws/IAttService"

//通知通过ID
#define findNoticesById @"http://13822767713.xicp.net/smart/ws/IAttService"

//寻找消息列表
#define findMyMsgList @"http://13822767713.xicp.net/smart/ws/IAttService"

//聊天
#define findMyMsg @"http://13822767713.xicp.net/smart/ws/IAttService"
//发送
#define saveMessage @"http://13822767713.xicp.net/smart/ws/IAttService"

//对比
#define findAttendWorkHourByUserMonth @"http://13822767713.xicp.net/smart/ws/IAttService"

//音频
#define vadaMusic @"http://13822767713.xicp.net/smart/"

//修改我的头像
#define modifyMyImage @"http://13822767713.xicp.net/smart/ws/IAttService"

//寻找我的头像
#define findMyImage @"http://13822767713.xicp.net/smart/ws/IAttService"

//产品介绍
#define funcaa1 @"http://13822767713.xicp.net/smart/phone/product"

//客服中心
#define faqaa1 @"http://13822767713.xicp.net/smart/phone/faq"

//公司官网
#define NetLine @"http://www.attonline.com.cn"

//产品协议
#define AgreementLine @"http://13822767713.xicp.net/smart/phone/licence"

//寻找所有假期
#define findAllHolidayByMonth @"http://13822767713.xicp.net/smart/ws/IAttService"
