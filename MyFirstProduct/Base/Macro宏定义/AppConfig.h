
//项目配置宏
/*
 目录：
 1、App属性设置
   a.导航栏设置
   b.Tabbar设置
   c.状态栏设置
 2、App常用常量宏定义
 */
#ifndef StarGroups_AppConfig_h
#define StarGroups_AppConfig_h

/*---------App属性设置-------------*/
#define AppBackgroundColor      [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f]//页面背景颜色
/*------导航栏------*/
#define NavBarBackgroundColor    [UIColor colorWithRGBHex:0xE9ECF1];//导航栏背景色
#define NavBarTextColor [UIColor blackColor] //导航栏文字颜色

#define NavBackGroundImage @"" //导航栏背景图片名称
#define NavBackImage @"head_back" //导航栏返回按钮图片名称
#define NavBackImage_1 @"head_back" //白色导航栏返回按钮图片名称

/*------Tabbar栏------*/
#define TabbarTextNormalColor  [UIColor colorWithRed:169/255.0f green:180/255.0f blue:184/255.0f alpha:1.0f]//文字默认颜色
#define TabbarTextSelectColor  [UIColor blackColor]//文字选中颜色

#define TabbarTextFontSize 10

#define NavBarHeight iPhoneX?88:64
#define TabbarHeight iPhoneX?83:49
#define TopSafeAreaHeight 44
#define FootSafeAreaHeight 34

/*-----------状态栏----------------*/
/*
 UIStatusBarStyleDefault       - 黑色
 UIStatusBarStyleLightContent  - 白色
*/
#define AppStatusBarStyle UIStatusBarStyleDefault //状态栏样式


/*----------App常用常量宏定义-----------*/
#define LoadingGifImageName  @"lodding" //gif加载动画图片名称
#define DefaultContentImage    [UIImage imageNamed:@"video"]//默认内容图片
#define DefaultSmallContentImage  [UIImage imageNamed:@"defaultimage"]//默认商品小图片
#define DefaultAvatarImage     [UIImage imageNamed:@"img_my_portrait"]//默认头像

#define IsFirstIn @"IsFirstIn" //是否第一次启动
#define IsLoginIn @"IsLoginIn" //是否已登录

#define ServiceTelephone @"1234567890"


#define SuccessCode [resultDic[@"code"] intValue] == 200//请求成功状态码
#define ErrorToast  resultDic[@"info"]
#define SecondTimes 60 //验证码读秒时限
#define ShareSessionId [UserinfoManager sharedData].userModel.authentication //请求的sessiond值




//列表视图常量
#define lineMargin 1
#define collectionCellHeight 250

#define MyCollectionInEdit @"MyCollectionInEdit"
#define MyCollectionIsDone @"MyCollectionIsDone"

#define ZJLanguage(key)  NSLocalizedString(key, nil)
#define LocalLanguage @"LocalLanguage"

#define RELOGIN @"RELOGIN"

#define ChooseCityName @"ChooseCityName"

#define ChangeCity @"ChangeCity"

#define UploadResume @"UploadResume"

#define ResumeUrl @"ResumeUrl"

#define ResumeName @"ResumeName"

typedef  void (^SendBackOBJMore)(id object,id object2,id object3);

//支付宝
#define APP_SCHEME @"doupaitv"

static NSString *const NSNotificationPayResultWeChat = @"wechatPayResult";

static NSString *const NSNotificationPayResultAliPay = @"aliPayResult";

static NSString *const NSNotificationPayResultUnion = @"unionPayResult";

static NSString *const NSNotificationRefreshUserBalance = @"refreshBalance";

static NSString *const NSNotificationLiveOnNewMessage = @"LiveOnNewMessage";

//读取图片
#define ImageNamed(...)                 [UIImage imageNamed:__VA_ARGS__]
//设置无透明度的颜色
#define RGB(R, G, B)                    [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
//录音存放路径
#define SoundFilePath           [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"SoundFile"]
//视频存放路径
#define VideoFilePath           [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"VideoFile"]

#endif
