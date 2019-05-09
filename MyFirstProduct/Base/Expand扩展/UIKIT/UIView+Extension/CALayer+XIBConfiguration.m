//
//  CALayer+XIBConfiguration.m
//
//  Created by 陈伟强 on 16/7/21.
//

#import "CALayer+XIBConfiguration.h"

@implementation CALayer (XIBConfiguration)
-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

-(void)setShadowUIColor:(UIColor*)color
{
    self.shadowColor = color.CGColor;
}

-(UIColor*)shadowUIColor
{
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
