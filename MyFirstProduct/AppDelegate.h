//
//  AppDelegate.h
//  MyFirstProduct
//
//  Created by cyh on 2018/11/24.
//  Copyright © 2018年 cyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabbarViewController.h"
static NSString *appKey = @"e54d41cec0a495b55d29d113";
//通道
static NSString *channel = @"Publish channel";
static BOOL isProduction = true;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseTabbarViewController *baseTabbar;
@property (assign, nonatomic) NSInteger rotateDirection;
@end

