//
//  ZJBadgeBtn.m
//  PearlRiverSeec
//
//  Created by kunge on 2017/12/22.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import "ZJBadgeBtn.h"

@implementation ZJBadgeBtn

-(void)setIsShowDot:(BOOL)isShowDot{
    _isShowDot = isShowDot;
    if (isShowDot) {
        self.badgeLabel.hidden = YES;
        [self.dotImage removeFromSuperview];
        self.dotImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_dot_red"]];
        self.dotImage.frame = CGRectMake(0, 0, 6, 6);
        [self addSubview:self.dotImage];
        self.dotImage.hidden = NO;
    }else{
        self.dotImage.hidden = YES;
    }
}

- (void)setBadgeString:(NSString *)badgeString{
    _badgeString = badgeString;
    self.badgeLabel = [self viewWithTag:77];
    
    if (self.badgeString && ![self.badgeString isEqualToString:@"0"]) {
        // Drawing code
        if (self.badgeLabel) {
            [self.badgeLabel removeFromSuperview];
        }
        self.dotImage.hidden = YES;
        self.badgeLabel = [[UILabel alloc]init];
        self.badgeLabel.backgroundColor = [UIColor colorWithRGBHexString:@"FFB712"];
        self.badgeLabel.tag = 77;
        self.badgeLabel.layer.masksToBounds = YES;
        self.badgeLabel.layer.cornerRadius = 16/2;
        self.badgeLabel.textColor = [UIColor whiteColor];
        self.badgeLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeLabel.font = [UIFont systemFontOfSize:11];
        self.badgeLabel.bounds = CGRectMake(0, 0, 16, 16);
        [self addSubview:self.badgeLabel];
        self.badgeLabel.text = badgeString;
    }else{
        self.badgeLabel.hidden = YES;
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 更改image的坐标
    CGPoint imageCenter = CGPointMake(self.frame.size.width-12/2,8);
    self.dotImage.center = imageCenter;
    
    // 更改label的坐标
    CGRect labelFrame = self.titleLabel.frame;
    labelFrame.origin.x = 0;
    labelFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + 5;
    labelFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = labelFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //NNSLog(@"btn:(%f,%f,%f,%f)",self.imageView.frame.origin.x,self.imageView.frame.origin.y,self.imageView.frame.size.width,self.imageView.frame.size.height);
    
    //image和label位置更换后，frame改变后再设置角标的值
    self.badgeLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame)-3, 8);
    
}

@end

