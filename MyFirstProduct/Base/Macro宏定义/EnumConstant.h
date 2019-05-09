
//枚举类文件

#ifndef EnumConstant_h
#define EnumConstant_h
/*
 例如：
 typedef NS_ENUM(NSInteger, OrderType) {
 AllOrderType = 0,    // 综合排序
 SalesType = 1,            // 销量排序
 PriceType = 2             //价格排序
 };
 */


typedef NS_ENUM(NSInteger, PackageType) {
    MonthPackageType = 0,    // 月卡
    DayPackageType = 1,      // 日卡
    TimePackageType = 2,     // 次卡
    DepositPackage = 3       // 押金
};


//typedef NS_ENUM(NSInteger, OrderShowType) {
//    AllOrderShowType = 0,    // 全部
//    WaitPayOrderType = 1,    // 待付款
//    WaitUseOrderType = 2,    // 待使用
//    HasUsedOrderType = 3,    // 已使用
//    HasCancelOrderType = 4,  // 已取消
//    WaitSendOrderType = 5,   // 待发货
//    WaitReciveOrderType = 6, // 待收货
//    HasComplteOrderType = 7  // 已完成
//};

//0 全部 1待支付，2待发货，3待收货，4待使用，5已完成/已使用，6已取消，7app已删除
typedef NS_ENUM(NSInteger, OrderShowType) {
    AllOrderShowType = 0,    // 全部
    WaitPayOrderType = 1,    // 待支付
    WaitSendOrderType = 2,   // 待发货
    WaitReciveOrderType = 3, // 待收货
    WaitUseOrderType = 4,    // 待使用
    HasUsedOrderType = 5,    // 已使用/已完成
    HasCancelOrderType = 6,  // 已取消
    HasComplteOrderType = 7  // app已删除
};

typedef NS_ENUM(NSInteger, UserInfoType) {
    PhysicalType = 0,     // 弹性福利-体检
    InsuranceType = 1,    // 商业保险
    PersonalType = 2     // 个人委托
};


//1个人委托，2个人体检，3商业保险，4实物
typedef NS_ENUM(NSInteger, SettlementType) {
    PersonalSetType = 1,     // 个人委托
    PhysicalSetType = 2,     // 弹性福利-体检
    InsuranceSetType = 3,    // 商业保险
    ProductSetType = 4       // 实物
};


//type 1正常发言  2礼物 3) {//直播结束 4) {//直播状态为付费 5){//是否开启了评论功能
typedef NS_ENUM(NSInteger, liveMessageType) {
    LiveMessages = 1,
    
    LiveGift = 2,
    EndLive = 3,
    VipLive = 4,
    openCommect = 5 ,
  
};

#endif /* EnumConstant_h */
