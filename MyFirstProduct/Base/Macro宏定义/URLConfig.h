
//紫鲸接口配置文件

#ifndef URLConfig
#define URLConfig


//#define DomainURL @"http://119.23.220.183:8083/"
#define DomainURL @"http://119.23.220.183:8084/"

 

#define  PicURL @"http://test.gxemp.com/"
 
//#define DomainURL @"http://192.168.1.158:80/"


 
//广兴
//新闻
#define URL_newsAll @"gxapi/newsManage/newsAll"

//新闻概览

#define URL_newsTop5 @"/gxapi/newsManage/newsTop5"

//通告
#define URL_noticAlll @"/gxapi/noticManage/noticAll"
//通告概览
#define URL_noticTop5 @"/gxapi/noticManage/noticTop5"

//通知
#define URL_getmessagebysystem @"/gxapi/messagemanage/getmessagebysystem"
//登陆
#define URL_checkLogin @"/gxapi/login/checkLogin"
//反馈
#define URL_gxfeedback @"/gxapi/publicInfoManage/feedback"
//考勤打卡
#define URL_wifiClockin @"/gxapi/attendanceModule/wifiClockin"
//考勤签到(统计)
#define URL_attendanceList @"/gxapi/attendanceModule/attendanceList"
//考勤记录
#define URL_attendanceAllList @"/gxapi/attendanceModule/attendanceAllList"

//云文档详情(获取对应文件和文件夹)
#define URL_GetFile @"/gxapi/PublicInfoManage/ResourceFile/GetFile"
//云文档点击(id：FirmAndDept)
#define URL_getfile @"/gxapi/resource/getfile"
//云文档点击(id：myAllFile)
#define URL_getlistjson @"/gxapi/resource/getlistjson"
//云文档点击(id：allDocument)
#define URL_getdocumentlistjson @"/gxapi/resource/getdocumentlistjson"
//云文档点击(id：allImage)
#define URL_getimagelistjson @"/gxapi/resource/getimagelistjson"
//云文档点击(id：allfilm)
#define URL_getfilmlistjson @"/gxapi/resource/getfilmlistjson"
//云文档点击(id：myStar)
#define URL_getcollectionlistjson @"/gxapi/resource/getcollectionlistjson"
//云文档点击(id：myShare)
#define URL_getmysharelistjson @"/gxapi/resource/getmysharelistjson"
//云文档点击(id：othersShare)
#define URL_getotherssharelistjson @"/gxapi/resource/getotherssharelistjson"
//云文档点击(id：meDept)
#define URL_getdeptalllistjson @"/gxapi/resource/getdeptalllistjson"
//云文档点击(id：recycledFile)
#define URL_getrecycledlistjson @"/gxapi/resource/getrecycledlistjson"

//获取剩余空间
#define URL_cloudsize @"/gxapi/resource/cloudsize"

//云文档详情(删除文件)
#define URL_removeform @"/gxapi/resource/removeform"

//云文档详情(收藏控件)
#define URL_getcollection @"/gxapi/resource/getcollection"

//云文档详情(分享控件)
#define URL_sharefilenew @"/gxapi/resource/sharefilenew"


//我发起的流程
#define URL_getruntimelist @"/gxapi/flow/getruntimelist"

//计算工作时长(请假)
#define URL_calcworkhours @"/gxapi/attendanceModule/calcworkhours"

//待我审批
#define URL_getbeforeprocessing @"/gxapi/flow/getbeforeprocessing"

//获取流程实例
#define URL_getprocessschemenew @"/gxapi/flow/getprocessschemenew"


//退出登陆
#define URL_outLogin @"/gxapi/login/outLogin"
//修改密码
#define URL_submitpassword @"/gxapi/personcenter/submitpassword"

//历史订单
#define URL_apporder @"/gxapi/mealOrderingModule/apporder"


//获取下一个工作日(点餐)
#define URL_getNexWorkDay @"/gxapi/mealOrderingModule/getNexWorkDay"


//创建请假流程
#define URL_createleaveprocess @"/gxapi/flow/createleaveprocess"


//创建加班(个人)
#define URL_createovertimepersonprocess @"/gxapi/flow/createovertimepersonprocess"

// 创建补卡流程
#define URL_createaddattendprocess @"/gxapi/flow/createaddattendprocess"

// 审批流程
#define URL_verificationprocess @"/gxapi/flow/verificationprocess"












/*
  格式：URL_模块缩写_接口标识名
  例如：#define URL_User_getToken @"/api/app/authuser/qiniuToken.json"
*/
//1.发送验证码
#define URL_commonMsg @"/api/common/msg.json"

//2.图片上传-----返回相对路径
#define URL_commonUpload @"/api/common/upload.json"

//3.手机号注册
#define URL_registerForPhone @"/api/auth/registerForPhone.json"

//4.用户详情
#define URL_live_user_view @"/api/live_user/view.json"

//5.手机验证码登录
#define URL_login @"/api/auth/login.json"

//6.手机密码登录
//#define URL_loginPassword @"gxapi/login/checkLogin"

//7.更新资料
#define URL_live_user_update @"/api/live_user/update.json"

//8.更新密码
#define URL_updatePassword @"/api/live_user/updatePassword.json"


//9.忘记密码--重置
#define URL_resetPassword @"/api/auth/resetPassword.json"

//10.公告列表
#define URL_noticelist @"/api/live_notice/list.json"


//11.会员套餐
#define URL_live_member_combo_view @"/api/live_member_combo/view.json"

//12.金币套餐
#define URL_live_gold_combo_view @"/api/live_gold_combo/view.json"

//13.客服
#define URL_kefu @"/api/common/kefu.json"

//14.金币充值
#define URL_userGoldRecharge @"api/payment/userGoldRecharge.json"

//15.会员套餐购买
#define URL_userRecharge @"/api/payment/userRecharge.json"


//16.通用-----文章详情
#define URL_article @"/api/common/article.json"

//17.直播预告列表查询
#define URL_advance_list @"/api/live/advance/list.json"

//18.直播间查询
#define URL_live_room_query @"/api/live/live_room/query.json"

//21.礼物列表查询
#define URL_live_giftlistAll @"/api/live/gift/listAll.json"

//24.会员套餐到期查询
#define URL_memberQuery @"/api/live_user/memberQuery.json"


//26.交流-评论提交
#define URL_live_liveChatSubmit @"/api/live/liveChat/submit.json"

//28.礼物赠送
#define URL_live_userGivingGifts @"/api/payment/userGivingGifts.json"

//29.用户消费记录
#define URL_userConsumptionLog @"/api/payment/userConsumptionLog.json"

//30.APP第三方登录---已绑定手机号直接登录成功返回
#define URL_socialLogin @"/api/auths/app/socialLogin.json"
//31.APP第三方登录---绑定手机号
#define URL_socialBindPhone @"/api/auths/socialBindPhone.json"

//35.PC获取IM登录信息
#define URL_getIMLoginInfo @"/api/live_user/getIMLoginInfo.json"
//36.判断手机是否注册过
#define URL_authsisPhone @"/api/auths/isPhone.json"

//38.获取当前观看人数-前端定时请求
#define URL_lookCount @"/api/live/look/count.json"

//39.IOS内购金币套餐列表
#define URL_live_gold_combo @"/api/live_gold_combo/ios/view.json"

#endif

