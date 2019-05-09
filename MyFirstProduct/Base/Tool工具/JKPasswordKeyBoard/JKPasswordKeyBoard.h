//
//  JKPasswordKeyBoard.h
//  YuePoetryBridge
//
//  Created by kunge on 2018/6/8.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKPasswordKeyBoard : UIView

+ (instancetype) keyboard;

//输入完成后回调 password为保存的密码
@property (nonatomic, copy) void(^completeBlock)(NSString *password);

//显示
- (void)showKeyboard;

//隐藏
- (void)hideKeyboard;

@end
