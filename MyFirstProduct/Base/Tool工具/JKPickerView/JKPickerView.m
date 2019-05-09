//
//  JKPickerView.m
//  JKPickerView
//
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "JKPickerView.h"


@implementation JKPickerView

#pragma mark - --- init 视图初始化 ---
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDefault];
        [self setupUI];
    }
    return self;
}

- (void)setupDefault
{
    // 1.设置数据的默认值
    _heightPicker      = 240;
    _widthPicker       = ZJScreenWidth;
    _contentMode       = JKPickerContentModeBottom;
    
    // 2.设置自身的属性
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:102.0/255];
    self.layer.opacity = 0.0;
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.添加子视图
    [self addSubview:self.contentView];

}

- (void)setupUI
{
    
}

-(void)reloadUI
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

#pragma mark - --- delegate 视图委托 ---

#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    [self remove];
}

- (void)selectedCancel
{
    [self remove];
}

#pragma mark - --- private methods 私有方法 ---


- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    if (self.contentMode == JKPickerContentModeBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y -= self.contentView.st_height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
        }];
    }else {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y -= (ZJScreenHeight+self.contentView.st_height)/2;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)remove
{
    if (self.contentMode == JKPickerContentModeBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += self.contentView.st_height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += (ZJScreenHeight+self.contentView.st_height)/2;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - setters 属性 
- (void)setHeightPicker:(CGFloat)heightPicker
{
    _heightPicker = heightPicker;
    self.contentView.st_height = heightPicker;
}

-(void)setWidthPicker:(CGFloat)widthPicker{
    _widthPicker = widthPicker;
    self.contentView.st_width = widthPicker;
    self.contentView.st_x = (ZJScreenWidth-widthPicker)/2;
    [self reloadUI];
}

- (void)setContentMode:(JKPickerContentMode)contentMode
{
    _contentMode = contentMode;
    if (contentMode == JKPickerContentModeCenter) {
        self.contentView.st_height += JKControlSystemHeight;
    }
}

#pragma mark - 懒加载
- (UIView *)contentView
{
    if (!_contentView) {
        CGFloat contentX = 0;
        CGFloat contentY = ZJScreenHeight;
        CGFloat contentW = self.widthPicker;
        CGFloat contentH = self.heightPicker;
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentView;
}



@end

