//
//  JKPickerView.h
//  JKPickerView
//
//  Copyright © 2016年 kunge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPickerViewUI.h"
#import "UIView+STFrame.h"

typedef NS_ENUM(NSInteger, JKPickerContentMode) {
    JKPickerContentModeBottom, // 1.选择器在视图的下方
    JKPickerContentModeCenter  // 2.选择器在视图的中间
};

@interface JKPickerView : UIButton

/** 1.内部视图 */
@property (nonatomic, strong) UIView *contentView;
/** 5.选择器的高度，default is 240 */
@property (nonatomic, assign)CGFloat heightPicker;
/** 6.选择器的宽度，default is 屏幕宽度 */
@property (nonatomic, assign)CGFloat widthPicker;
/** 7.视图的显示模式 */
@property (nonatomic, assign)JKPickerContentMode contentMode;


/**
 *  5.创建视图,初始化视图时初始数据
 */
- (void)setupUI;

/**
 *  6.刷新视图
 */
- (void)reloadUI;

/**
 *  7.显示
 */
- (void)show;

/**
 *  8.移除
 */
- (void)remove;

@end
