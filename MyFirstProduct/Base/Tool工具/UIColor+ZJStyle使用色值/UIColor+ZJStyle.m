//
//  UIColor+ZJStyle.m
//  EasyEducation
//
//  Created by kunge on 16/5/27.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "UIColor+ZJStyle.h"
#import "UIColor+Additions.h"

@implementation UIColor (ZJStyle)

+(UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+(UIColor *)ZJ_NavColor{
    return [UIColor colorWithRed:1/255.0 green:207/255. blue:12/255. alpha:1];
}

+(UIColor *)ZJ_WhiteColor{
    return [UIColor colorWithRed:255/255.0 green:255/255. blue:255/255. alpha:1];
}

+(UIColor *)ZJ_LightLineColor{
    return [UIColor colorWithRGBHexString:@"f3f3f3"];
}

+(UIColor *)ZJ_ViewBgColor{
    return [UIColor colorWithRGBHexString:@"ebedef"];
}

+(UIColor *)ZJ_redBackColor{
    return [UIColor colorWithRGBHexString:@"EC3847"alpha:1];
}

+(UIColor *)ZJ_shelterColor{
    return [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:0.4f];
}

+(UIColor *)ZJ_green{
    return [UIColor colorWithRGBHexString:@"20A760"];
}

+(UIColor *)ZJ_blue{
    return [UIColor colorWithRGBHexString:@"257BFF"];
}

+(UIColor *)ZJ_pink{
    return [UIColor colorWithRed:255/255.0f green:85/255.0f blue:127/255.0f alpha:1.0f];
}

+(UIColor *)ZJ_yellow{
    return [UIColor colorWithRed:255/255.0f green:182/255.0f blue:104/255.0f alpha:1.0f];
}

+(UIColor *)ZJ_red{
    return [UIColor colorWithRGBHexString:@"FF5253"];
}

+(UIColor *)ZJ_35Color{
    return [UIColor colorWithRed:35/255.0f green:35/255.0f blue:35/255.0f alpha:1.0f];
}

+(UIColor *)ZJ_999999Color{
    return [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
}

+(UIColor *)ZJ_666666Color{
    return [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
}

+(UIColor *)ZJ_333333Color{
    return [UIColor colorWithRed:43/255.0f green:43/255.0f blue:43/255.0f alpha:1.0f];
}

+(UIColor *)ZJ_b40000Color{
    return [UIColor colorWithRGBHexString:@"b40000"];
}



@end
