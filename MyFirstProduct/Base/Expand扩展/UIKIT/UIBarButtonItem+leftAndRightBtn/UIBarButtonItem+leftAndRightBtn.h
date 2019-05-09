//
//  UIBarButtonItem+leftAndRightBtn.h
//  ColorBridge
//
//  Created by kunge on 2018/3/27.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NavItemBtnWidth 45

@interface UIBarButtonItem (leftAndRightBtn)

+ (UIBarButtonItem *)ittemLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector;
+ (UIBarButtonItem *)itemLeftItemWithIcon:(UIImage *)icon selector:(SEL)selector;
+ (UIBarButtonItem *)itemLeftItemWithTitle:(NSString *)title selector:(SEL)selector;
+ (UIBarButtonItem *)ittemRightItemWithIcon:(UIImage *)icon selector:(SEL)selector;
+ (UIBarButtonItem *)ittemRightItemWithTitle:(NSString *)title selector:(SEL)selector;


@end
