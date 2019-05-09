//
//  UIViewController+PhoneAndPadinit.m
//  WIFIEarnMoney
//
//  Created by 冯华恒 on 2017/2/27.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import "UIViewController+PhoneAndPadinit.h"

@implementation UIViewController (PhoneAndPadinit)

+(UIViewController *)ControllerloadNib:(Class) aClass {
    NSString *className = NSStringFromClass(aClass);
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return [[aClass alloc] initWithNibName:[NSString stringWithFormat:@"%@",className] bundle:nil];
    }
    else
    {
        return [[aClass alloc] initWithNibName:[NSString stringWithFormat:@"%@_iPad",className] bundle:nil];
    }
    
    
}

+(UIViewController *)ControllerloadNib {
    return [UIViewController ControllerloadNib:self];
}

@end
