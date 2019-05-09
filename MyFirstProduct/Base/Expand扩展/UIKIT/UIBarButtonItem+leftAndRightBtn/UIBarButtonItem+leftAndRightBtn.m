//
//  UIBarButtonItem+leftAndRightBtn.m
//  ColorBridge
//
//  Created by kunge on 2018/3/27.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import "UIBarButtonItem+leftAndRightBtn.h"

@implementation UIBarButtonItem (leftAndRightBtn)

+ (UIBarButtonItem *)ittemLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector {
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

+ (UIBarButtonItem *)itemLeftItemWithIcon:(UIImage *)icon selector:(SEL)selector {
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

+ (UIBarButtonItem *)itemLeftItemWithTitle:(NSString *)title selector:(SEL)selector {
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

+ (UIBarButtonItem *)ittemRightItemWithIcon:(UIImage *)icon selector:(SEL)selector {
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

+ (UIBarButtonItem *)ittemRightItemWithTitle:(NSString *)title selector:(SEL)selector {
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
    [btn setTitleColor:[UIColor ZJ_blue] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor ZJ_blue] forState:UIControlStateHighlighted];
    CGSize titleSize = [title ex_sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(ZJScreenWidth, MAXFLOAT)];
    float leight = titleSize.width;
    [btn setFrame:CGRectMake(0, 0, leight, NavItemBtnWidth)];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

@end
