

#import "BaseTabbarViewController.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"

//#import "HomeViewController.h"
//#import "VideoViewController.h"
//#import "SelectViewController.h"
//
//#import "LoginViewController.h"
//#import "MineViewController.h"
//#import "AddressBookVC.h"
@interface BaseTabbarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>

@property(nonatomic,strong)UIButton * btn;

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;

    [self addDcChildViewContorller];
    
    if (![UserinfoManager sharedData].userModel)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self logininit];
        });
    }
    
 
    
}


-(void)logininit
{
//    LoginViewController*vc=[LoginViewController new];
//    UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:vc];
//    [self presentViewController:nvc animated:1 completion:nil];
}

#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{
                                @"ClassName"    : @"HomeVC",
                                @"TabTitle"     : @"首页",
                                @"NavTitle"     : @"",
                                @"normalImage"  : @"table_ic_home",
                                @"selectImage"  : @"table_ic_home_b"
                                },
                            @{
                                @"ClassName"    : @"WorkAreaVC",
                                @"TabTitle"     : @"工作区",
                                @"NavTitle"     : @"",
                                @"normalImage"  : @"table_ic_2",
                                @"selectImage"  : @"table_ic_2_b"
                                },
                            @{
                                @"ClassName"    : @"ImformationVC",
                                @"TabTitle"     : @"通知",
                                @"NavTitle"     : @"",
                                @"normalImage"  : @"table_ic_3",
                                @"selectImage"  : @"table_ic_3_b"
                              },
                            @{
                                @"ClassName"    : @"CommunicationVC",
                                @"TabTitle"     : @"通讯",
                                @"NavTitle"     : @"",
                                @"normalImage"  : @"table_ic_4",
                                @"selectImage"  : @"table_ic_4_b"
                                },
                            @{
                                @"ClassName"    : @"MineViewController",
                                @"TabTitle"     : @"我的",
                                @"NavTitle"     : @"",
                                @"normalImage"  : @"table_ic_5",
                                @"selectImage"  : @"table_ic_5_b"
                                }
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[@"ClassName"]) new];
        vc.navigationItem.title = ZJLanguage(dict[@"NavTitle"]);
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        
        item.image =  [[UIImage imageNamed:dict[@"normalImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:dict[@"selectImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        float origin = -9 + 6;
//        item.imageInsets = UIEdgeInsetsMake(origin, 3, -origin,0);//（当只有图片的时候）需要自动调整
//        item.titlePositionAdjustment = UIOffsetMake(-2 + 8, 2-8);
//        item.imageInsets = UIEdgeInsetsMake(6, 0, -6,0);
        
//        item.titlePositionAdjustment = UIOffsetMake(0, -2);
        
        
        //title设置
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:TabbarTextNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:TabbarTextFontSize]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:TabbarTextSelectColor,NSFontAttributeName:[UIFont systemFontOfSize:TabbarTextFontSize]} forState:UIControlStateSelected];
        item.title = ZJLanguage(dict[@"TabTitle"]);
        [self addChildViewController:nav];
    }];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    //更换第一图标
//    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
////    _btn.userInteractionEnabled=NO;
//    _btn.backgroundColor = [UIColor clearColor];
//    _btn.frame = CGRectMake(ZJScreenWidth/2-45/2, 0, 45, 45);
//    [_btn setImage:[UIImage imageNamed:@"icon_release_"] forState:UIControlStateNormal];
//    [_btn setImage:[UIImage imageNamed:@"icon_release_"] forState:UIControlStateSelected];
//    _btn.selected = YES;
//    _btn.tag=999;
//    [self.tabBar addSubview:_btn];
//    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
////    self.tabBar.backgroundColor = [UIColor ZJ_WhiteColor];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    if (viewController ==self.viewControllers[2]) {
//        PublishContentVC *vc=[PublishContentVC new];
//        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
//        [viewController presentViewController:nav animated:YES completion:nil];
//          return NO;
//    }
    return YES;
}

//-(void)btnAction
//{
//    NSLog(@"---");
//}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
//    [self tabBarButtonClick:[self getTabBarButton]];
}

//- (UIControl *)getTabBarButton{
//    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
//
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
//            [tabBarButtons addObject:tabBarButton];
//        }
//    }
//
//    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
//    return tabBarButton;
//}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}

#pragma mark - UITabBar delegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    if(item.tag == 100){
//        _btn.selected=YES;
//    }else{
//        _btn.selected=NO;
//    }
//    NSLog(@"AA%ld",item.tag);
}


@end
