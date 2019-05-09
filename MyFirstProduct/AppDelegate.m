//
//  AppDelegate.m
//  MyFirstProduct
//
//  Created by cyh on 2018/11/24.
//  Copyright © 2018年 cyh. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//应用程序启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //收键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = 0;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    [SVProgressHUD setMinimumDismissTimeInterval:3];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    //解决ios11的UIScrollView下移问题
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    //设置屏幕、屏幕的根控制器
    //显示屏幕
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _baseTabbar = [[BaseTabbarViewController alloc] init];
    self.window.rootViewController = _baseTabbar;
    [self.window makeKeyAndVisible];
    
    return YES;
}

//当应用程序即将从活动状态移动到非活动状态时发送。这可能发生在某些类型的临时中断(例如传入的电话或SMS消息)，或者当用户退出应用程序并开始转换到后台状态时。
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

//使用此方法释放共享资源，保存用户数据，使计时器失效，并存储足够的应用程序状态信息，以便在应用程序稍后终止时将其恢复到当前状态。
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//作为从后台到活动状态转换的一部分调用;在这里，您可以撤消在进入后台时所做的许多更改。
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

//重新启动在应用程序处于非活动状态时暂停(或尚未启动)的任何任务。如果应用程序以前在后台，可以选择刷新用户界面。
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//应用程序即将终止时调用。适当时保存数据。
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
