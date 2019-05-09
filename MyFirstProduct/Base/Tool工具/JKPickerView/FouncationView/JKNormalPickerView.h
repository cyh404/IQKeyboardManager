//
//  JKNormalPickerView.h
//  WIFIEarnMoney
//
//  Created by kunge on 2017/3/7.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import "JKPickerView.h"

@interface JKNormalPickerView : JKPickerView

/** 0.中间选择框的高度，default is 35*/
@property (nonatomic, assign)CGFloat heightPickerComponent;
/** 1.标题，default is nil */
@property(nonatomic, nonatomic,copy) NSString   *title;
/** 2.字体，default is nil (system font 17 plain) */
@property(nonatomic, nonatomic,strong) UIFont   *font;
/** 3.字体颜色，default is nil (text draws black) */
@property(nonatomic, nonatomic,strong) UIColor  *titleColor;
/** 4.按钮边框颜色颜色，default is RGB(205, 205, 205) */
@property(nonatomic, nonatomic,strong) UIColor  *borderButtonColor;
/** 5.头部背景视图颜色，default is RGB(230, 116, 23) */
@property(nonatomic, nonatomic,strong) UIColor  *headBackColor;

@property (nonatomic,copy) void (^selectBlock)(NSInteger index,NSString *selectStr);
@property (nonatomic,strong)NSMutableArray *selectArr;

@end
