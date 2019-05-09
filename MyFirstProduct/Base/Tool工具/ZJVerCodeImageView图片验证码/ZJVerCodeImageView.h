//
//  ZJVerCodeImageView.h
//  ColorBridge
//
//  Created by kunge on 2018/1/30.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZJCodeImageBlock)(NSString *codeStr);

@interface ZJVerCodeImageView : UIView

@property (nonatomic, strong) NSString *imageCodeStr;
@property (nonatomic, assign) BOOL isRotation;
@property (nonatomic, copy) ZJCodeImageBlock bolck;

-(void)freshVerCode;

@end
