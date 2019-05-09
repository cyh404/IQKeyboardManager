
//紫鲸接口配置文件

#ifndef URLConfigJK
#define URLConfigJK


//获取今天点餐记录(二维码使用)
#define URL_getListByNowDate @"/gxapi/mealOrderingModule/getqrorder"
//点餐详情
#define URL_orderListByDay @"/gxapi/mealOrderingModule/orderListByDay"
//初次点餐
#define URL_createOrder @"/gxapi/mealOrderingModule/createOrder"
//取消点餐
#define URL_cancelOrder @"/gxapi/mealOrderingModule/cancelOrder"
//再次点餐
#define URL_reOrder @"/gxapi/mealOrderingModule/ReOrder"
//获取餐厅列表
#define URL_getRestaurants @"/gxapi/mealOrderingModule/getRestaurants"

//关于我们
#define URL_getlist @"/gxapi/course/getlist"

//获取所有用户列表(广兴内部)
#define URL_getuserlist @"/gxapi/user/getuserlist"

//获取群列表
#define URL_getgrouplist @"/gxapi/hx/getgrouplist"

//获取指定用户好友列表(环信用户列表)
#define URL_getuserfriendinfobyid @"/gxapi/hx/getuserfriendinfobyid"

//2.1    获取指定用户个人信息(环信)
#define URL_getuserinfobyid @"/gxapi/hx/getuserinfobyid"



#endif

