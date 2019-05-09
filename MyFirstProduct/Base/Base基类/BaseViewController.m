
//基类

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabbarViewController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //方法2:通过父视图NaviController来设置
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@""
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(backMethod)];

    //设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavBackGroundImage]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];


    //状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    //title颜色和字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:NavBarTextColor,
                                               NSFontAttributeName:[UIFont systemFontOfSize:18]};

    if ([UIDevice currentDevice].systemVersion.floatValue > 7.0) {
        //导航背景颜色
        self.navigationController.navigationBar.barTintColor = NavBarBackgroundColor;
    }
//    [[UINavigationBar appearance] setTintColor:NavBarTextColor];


    //主要是以下两个图片设置
    NSString *imageName = NavBackImage;
    if (AppStatusBarStyle == UIStatusBarStyleLightContent) {
        imageName = NavBackImage_1;
    }
    UIImage *image = [UIImage imageNamed:imageName];

    self.navigationController.navigationBar.backIndicatorImage = image;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = image;
    self.navigationItem.backBarButtonItem = backItem;
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.mj_size = CGSizeMake(40, 30);
        [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        // 让按钮内部的所有内容左对齐
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 这里微调返回键的位置可以让它看上去和左边紧贴
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    [self setUPUI];

}
-(void)cleanNavBar
{
    self.navigationController.navigationBar.translucent = YES;
    //    //    导航栏变为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    //    让黑线消失的方法
    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
    {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    //        [self setNavBarColor:[UIColor clearColor]];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    
}
//-(void)showNavBar
//{
//    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
//    NSString *imageName = NavBackImage;
//
//    self.navigationItem.leftBarButtonItem = [self ittemLeftItemWithIcon:[UIImage imageNamed:imageName] title:@"" selector:@selector(backAction:)];
//
//
//    self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor] size:CGSizeMake(self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height + 20)]
//                                                 forBarPosition:UIBarPositionAny
//                                                     barMetrics:UIBarMetricsDefault];
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
    [self showNavBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavBackGroundImage]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
     [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - Method
-(void)setUPUI{
    //设置页面背景色
    self.view.backgroundColor = AppBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.tabBarController.tabBar.translucent = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToLogin:) name:RELOGIN object:nil];

}

-(void)backMethod{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loginSuccessActionWithDict:(NSDictionary *)dict{
    UNSaveObject(@"Yes", IsLoginIn);
}

#pragma mark - LoadingView和空数据视图显示隐藏
#pragma mark 显示Loading
-(void)showLoading{
    [self.view showLoadingView];
}

#pragma mark 隐藏Loading
-(void)hideLoading{
    [self.view hideLoadingView];
}

#pragma mark - toast提示(只文字)
-(void)showToast:(NSString *)toast{
    [MBProgressHUD showWithMessage:toast onView:self.view.window];
}

#pragma mark 回到首页
-(void)backToHome{
   
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    window.rootViewController = [[BaseTabbarViewController alloc]init];
}

-(BOOL)judgeLoginStatus{
    NSString *login = UNGetObject(IsLoginIn);
    if([login isEqualToString:@"Yes"]){
        return YES;
    }
    return NO;
}

-(void)backToLogin:(NSNotification *)notification{
    [[UserinfoManager sharedData] logout];
    [self goToLogin];
}

#pragma mark 拨打电话
-(void)callWithNumber:(NSString *)number{
    //弹框提示，打完电话回到应用
    NSMutableString *str = [[NSMutableString alloc]initWithFormat:@"telprompt://%@",number];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    
    //直接打电话不弹框提示，不回到应用
    //    NSMutableString *string= [[NSMutableString alloc]initWithFormat:@"tel:%@",ServiceTelephone];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

#pragma mark - 导航栏
#pragma mark 隐藏导航栏
-(void)hideNavBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.edgesForExtendedLayout = UIRectEdgeTop;
}

#pragma mark 显示导航栏
-(void)showNavBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark 跳转网页
-(void)skipToSimpleWebWithUrl:(NSString *)url andTitle:(NSString *)title{
    SimpleWebVC *simpleWeb = [[SimpleWebVC alloc] init];
    simpleWeb.url = url;
    simpleWeb.title = title;
    [self.navigationController pushViewController:simpleWeb animated:YES];
}

-(void)skipToSimpleWebWithHtmlStr:(NSString *)htmlStr andTitle:(NSString *)title{
    SimpleWebVC *simpleWeb = [[SimpleWebVC alloc] init];
    simpleWeb.htmlStr = htmlStr;
    simpleWeb.title = title;
    [self.navigationController pushViewController:simpleWeb animated:YES];
}

#pragma mark 导航栏按钮
- (void)setLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector {
    self.navigationItem.leftBarButtonItem = [self ittemLeftItemWithIcon:icon title:title selector:selector];
}
- (void)setLeftItemWithIcon:(UIImage *)icon selector:(SEL)selector {
    UIBarButtonItem *item = [self ittemLeftItemWithIcon:icon selector:selector];
    self.navigationItem.leftBarButtonItem = item;
}

- (UIBarButtonItem *)ittemLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector {
    UIBarButtonItem *item;
    if (!icon && title.length == 0) {
        item = [[UIBarButtonItem new] initWithCustomView:[UIView new]];
        return item;
    }
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:NavBarTextColor forState:UIControlStateNormal];
    [btn setTitleColor:NavBarTextColor forState:UIControlStateHighlighted];
    CGSize titleSize = [title ex_sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(ZJScreenWidth, MAXFLOAT)];
    float leight = titleSize.width;
    if (icon) {
        leight += icon.size.width;
        [btn setImage:icon forState:UIControlStateNormal];
        [btn setImage:icon forState:UIControlStateHighlighted];
        if (title.length == 0) {
            //文字没有的话，点击区域+10
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 33);
        } else {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        }
    }
    if (title.length == 0) {
        //文字没有的话，点击区域+10
        leight = leight + 30;
    }
    view.frame = CGRectMake(0, 0, leight, NavItemBtnWidth);
    btn.frame = CGRectMake(-5, 0, leight, NavItemBtnWidth);
    [view addSubview:btn];
    
    item = [[UIBarButtonItem alloc] initWithCustomView:view];
    return item;
}

- (void)setRightItemWithTitle:(NSString *)title selector:(SEL)selector {
    UIBarButtonItem *item = [self ittemRightItemWithTitle:title selector:selector];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setRightItemWithIcon:(UIImage *)icon selector:(SEL)selector {
    UIBarButtonItem *item = [self ittemRightItemWithIcon:icon selector:selector];
    self.navigationItem.rightBarButtonItem = item;
}

- (UIBarButtonItem *)ittemRightItemWithIcon:(UIImage *)icon selector:(SEL)selector {
    UIBarButtonItem *item;
    if (!icon) {
        item = [[UIBarButtonItem new] initWithCustomView:[UIView new]];
        return item;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    float leight = icon.size.width;
    [btn setImage:icon forState:UIControlStateNormal];
    [btn setImage:icon forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [btn setFrame:CGRectMake(0, 0, leight, NavItemBtnWidth)];
    
    item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (UIBarButtonItem *)ittemRightItemWithTitle:(NSString *)title selector:(SEL)selector {
    UIBarButtonItem *item;
    if (title.length == 0) {
        item = [[UIBarButtonItem new] initWithCustomView:[UIView new]];
        return item;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:NavBarTextColor forState:UIControlStateNormal];
    [btn setTitleColor:NavBarTextColor forState:UIControlStateHighlighted];
    CGSize titleSize = [title ex_sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(ZJScreenWidth, MAXFLOAT)];
    float leight = titleSize.width;
    [btn setFrame:CGRectMake(0, 0, leight, NavItemBtnWidth)];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
- (UIBarButtonItem *)ittemLeftItemWithIcon:(UIImage *)icon selector:(SEL)selector {
    UIBarButtonItem *item;
    if (!icon) {
        item = [[UIBarButtonItem new] initWithCustomView:[UIView new]];
        return item;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    float leight = icon.size.width;
    [btn setImage:icon forState:UIControlStateNormal];
    [btn setImage:icon forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn setFrame:CGRectMake(0, 0, leight, NavItemBtnWidth)];
    
    item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}
#pragma mark 环信被动退出登陆
- (void)didReceiveMessages:(NSArray *)aMessages
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getUnReadCount" object:nil];
}

- (void)didLoginFromOtherDevice
{
    
    [[UserinfoManager sharedData] logout];
     [self goToLogin];
    [self.view showToast:@"有设备同时登陆此账号"];
}

- (void)didRemovedFromServer
{
  
    [[UserinfoManager sharedData] logout];
    [self goToLogin];
    [self.view showToast:@"有设备同时登陆此账号"];
}

@end
