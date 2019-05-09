//
//  UIView+loadNib.m
//  WIFIEarnMoney
//
//  Created by 冯华恒 on 2017/3/8.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import "UIView+loadNib.h"

@implementation UIView (loadNib)
+(UIView *)loadNib:(Class) aClass {
    NSString *className = NSStringFromClass(aClass);
    return (UIView *)[[[NSBundle bundleForClass:aClass] loadNibNamed:className owner:nil options:nil] firstObject];
}

+(UIView *)loadNib {
    return [UIView loadNib:self];
}
@end
