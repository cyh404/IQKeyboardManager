//
//  PsychologicalPriceView.h
//  XinNongTongApp
//
//  Created by kunge on 2017/9/27.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import "JKPickerView.h"

@interface PsychologicalPriceView : JKPickerView

/** 3.中间选择框的高度，default is 28*/
@property (nonatomic, assign)CGFloat heightPickerComponent;

/** 1.标题，default is nil */
@property(nonatomic,copy) NSString          *title;
/** 2.字体，default is nil (system font 17 plain) */
@property(nonatomic,strong) UIFont   *font;
/** 3.字体颜色，default is nil (text draws black) */
@property( nonatomic,strong) UIColor  *titleColor;
/** 4.按钮边框颜色颜色，default is RGB(205, 205, 205) */
@property( nonatomic,strong) UIColor  *borderButtonColor;
/** 5.头部背景视图颜色，default is RGB(230, 116, 23) */
@property( nonatomic,strong) UIColor  *headBackColor;

@property (nonatomic,copy) void (^pricePickBlock)(NSString *fristPrice,NSString *secondPrice);

@end
