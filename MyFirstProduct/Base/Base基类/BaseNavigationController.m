
//导航栏基类

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>


@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];    
    // Do any additional setup after loading the view.

    //设置导航栏背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:NavBackGroundImage]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    
    
    //状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:AppStatusBarStyle];
    
    //title颜色和字体
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:NavBarTextColor,
                                               NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    if ([UIDevice currentDevice].systemVersion.floatValue > 7.0) {
        //导航背景颜色
        self.navigationBar.barTintColor = NavBarBackgroundColor;
    }
    [[UINavigationBar appearance] setTintColor:NavBarTextColor];
  
    
    //返回按钮图片设置
    NSString *imageName = NavBackImage;
    if (AppStatusBarStyle == UIStatusBarStyleLightContent) {
        imageName = NavBackImage_1;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width-1, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
   
}
-(void)setGestureBack
{
    //  这句很核心 稍后讲解
    id target = self.interactivePopGestureRecognizer.delegate;
    //  这句很核心 稍后讲解
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    //  创建pan手势 作用范围是全屏
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
}

//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    //解决与左滑手势冲突
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    // 过滤执行过渡动画时的手势处理
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    return self.childViewControllers.count == 1 ? NO : YES;
}
#pragma mark - push后隐藏TabBar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count >= 1) {
        // 左上角的返回按钮
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.mj_size = CGSizeMake(40, 30);
//        NSString *imageName = NavBackImage;
////        if (AppStatusBarStyle == UIStatusBarStyleLightContent) {
////            imageName = NavBackImage_1;
////        }
//        [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        // 让按钮内部的所有内容左对齐
//        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        //        [backButton sizeToFit];
//        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 这里微调返回键的位置可以让它看上去和左边紧贴
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back:(UIButton *)vc
{
//    if ([self.visibleViewController isKindOfClass:[PaySuccessVC class]]) {
//        [self popToRootViewControllerAnimated:YES];
//    }else if ([self.visibleViewController isKindOfClass:[OrderDetailVC class]]) {
//        [self popToRootViewControllerAnimated:YES];
//    }else if ([self.visibleViewController isKindOfClass:[PayOrderViewController class]]) {
//        [self popToRootViewControllerAnimated:YES];
//    }else{
//        [self popViewControllerAnimated:YES];// 这里不用写self.navigationController，因为它自己就是导航控制器
//    }
}

 
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (BOOL)shouldAutorotate
{
    
    return NO;
}
@end
