//
//  OpenLockTimeView.h
//  STPickerView
//
//  Created by kunge on 2016/12/28.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "JKPickerView.h"
typedef NS_ENUM(NSInteger, JKPickerTypeMode) {
    JKPickerTimeType,    // 1.次数  1-30
    JKPickerMonthType,   // 2.月数  1-12
    JKPickerHourType     // 3.小时  4-24
};

@interface OpenLockTimeView : JKPickerView

/** 0.中间选择框的高度，default is 35*/
@property (nonatomic, assign)CGFloat heightPickerComponent;
/** 1.标题，default is nil */
@property(nonatomic, nonatomic,copy) NSString  *title;
/** 2.字体，default is nil (system font 17 plain) */
@property(nonatomic, nonatomic,strong) UIFont   *font;
/** 3.字体颜色，default is nil (text draws black) */
@property(nonatomic, nonatomic,strong) UIColor  *titleColor;
/** 4.按钮边框颜色颜色，default is RGB(205, 205, 205) */
@property(nonatomic, nonatomic,strong) UIColor  *borderButtonColor;
/** 5.头部背景视图颜色，default is RGB(230, 116, 23) */
@property(nonatomic, nonatomic,strong) UIColor  *headBackColor;

@property(nonatomic,assign)JKPickerTypeMode pickerTypeMode;

@property (nonatomic,copy) void (^timeClickBlock)(NSInteger openTime);

@end
