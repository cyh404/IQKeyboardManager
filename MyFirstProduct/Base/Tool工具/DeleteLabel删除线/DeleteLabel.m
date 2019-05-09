//
//  DeleteLabel.m
//  HuaXinEGo
//
//  Created by kunge on 2017/8/16.
//  Copyright © 2017年 ssl. All rights reserved.
//

#import "DeleteLabel.h"

@implementation DeleteLabel

- (void)drawRect:(CGRect)rect
{
    // 调用super的drawRect:方法,会按照父类绘制label的文字
    [super drawRect:rect];
    
    // 取文字的颜色作为删除线的颜色
    [self.textColor set];
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    // 绘制(这个数字是为了找到label的中间位置,0.35这个数字是试出来的,如果不在中间可以自己调整)
    UIRectFill(CGRectMake(0, h * 0.5, w, 0.8));
}

@end
