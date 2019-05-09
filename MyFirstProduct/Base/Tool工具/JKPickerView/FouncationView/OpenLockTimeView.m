//
//  OpenLockTimeView.m
//  JKPickerView
//
//  Created by kunge on 2016/12/28.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "OpenLockTimeView.h"


@interface OpenLockTimeView()<UIPickerViewDataSource, UIPickerViewDelegate>

/** 2.边线,选择器和上方tool之间的边线 */
@property (nonatomic, strong)UIView *lineView;
/** 3.选择器 */
@property(nonatomic,strong)UIPickerView *pickerView;
/** 4.左边的按钮 */
@property (nonatomic, strong)UIButton *buttonLeft;
/** 5.右边的按钮 */
@property (nonatomic, strong)UIButton *buttonRight;
/** 6.标题label */
@property (nonatomic, strong)UILabel *labelTitle;
/** 7.下边线,在显示模式是STPickerContentModeCenter的时候显示 */
@property (nonatomic, strong)UIView *lineViewDown;
/** 8.头部按钮颜色背景视图 */
@property (nonatomic, strong)UIView *headBackView;

@property(nonatomic,strong)UIImageView *upLineImage;
@property(nonatomic,strong)UIImageView *downLineImage;

/** 1.开锁次数 */
@property (nonatomic, assign)NSInteger openTime;
/** 2 最大值 */
@property (nonatomic, assign)NSInteger startTime;
@property (nonatomic, assign)NSInteger maxTime;
@property (nonatomic,strong)NSString *typeStr;

@end

@implementation OpenLockTimeView

#pragma mark - 懒加载
- (UIView *)lineView
{
    if (!_lineView) {
        CGFloat lineX = 0;
        CGFloat lineY = JKControlSystemHeight;
        CGFloat lineW = self.contentView.st_width;
        CGFloat lineH = 0.5;
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        [_lineView setBackgroundColor:self.borderButtonColor];
    }
    return _lineView;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = self.contentView.st_width;
        CGFloat pickerH = self.contentView.st_height - self.lineView.st_bottom;
        CGFloat pickerX = 0;
        CGFloat pickerY = self.lineView.st_bottom;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pickerView;
}

-(UIImageView *)upLineImage{
    if (!_upLineImage) {
        _upLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 1)];
        _upLineImage.center = CGPointMake(_pickerView.center.x, _pickerView.center.y-20);
        _upLineImage.backgroundColor = [UIColor lightGrayColor];
    }
    return _upLineImage;
}

-(UIImageView *)downLineImage{
    if (!_downLineImage) {
        _downLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 1)];
        _downLineImage.center = CGPointMake(_pickerView.center.x, _pickerView.center.y+20);
        _downLineImage.backgroundColor = [UIColor lightGrayColor];
    }
    return _downLineImage;
}

-(UIView *)headBackView{
    if (!_headBackView) {
        CGFloat pickerW = self.contentView.st_width;
        CGFloat pickerH = JKControlSystemHeight;
        CGFloat pickerX = 0;
        CGFloat pickerY = 0;
        _headBackView = [[UIView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_headBackView setBackgroundColor:self.headBackColor];
    }
    return _headBackView;
}

- (UIButton *)buttonLeft
{
    if (!_buttonLeft) {
        CGFloat leftW = JKControlSystemHeight;
        CGFloat leftH = self.lineView.st_top - JKMargin;
        CGFloat leftX = JKMarginBig;
        CGFloat leftY = (self.lineView.st_top - leftH) / 2;
        _buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(leftX, leftY, leftW, leftH)];
        [_buttonLeft setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonLeft setTitleColor:self.titleColor forState:UIControlStateNormal];
        //        [_buttonLeft addBorderColor:self.borderButtonColor];
        [_buttonLeft.titleLabel setFont:self.font];
        [_buttonLeft addTarget:self action:@selector(selectedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonLeft;
}

- (UIButton *)buttonRight
{
    if (!_buttonRight) {
        CGFloat rightW = self.buttonLeft.st_width;
        CGFloat rightH = self.buttonLeft.st_height;
        CGFloat rightX = self.contentView.st_width - rightW - self.buttonLeft.st_x;
        CGFloat rightY = self.buttonLeft.st_y;
        _buttonRight = [[UIButton alloc]initWithFrame:CGRectMake(rightX, rightY, rightW, rightH)];
        [_buttonRight setTitle:@"确定" forState:UIControlStateNormal];
        [_buttonRight setTitleColor:self.titleColor forState:UIControlStateNormal];
        //        [_buttonRight addBorderColor:self.borderButtonColor];
        [_buttonRight.titleLabel setFont:self.font];
        [_buttonRight addTarget:self action:@selector(selectedOk) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonRight;
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        CGFloat titleX = self.buttonLeft.st_right + JKMarginSmall;
        CGFloat titleY = 0;
        CGFloat titleW = self.contentView.st_width - titleX * 2;
        CGFloat titleH = self.lineView.st_top;
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        [_labelTitle setTextColor:self.titleColor];
        [_labelTitle setFont:self.font];
        _labelTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _labelTitle;
}

- (UIView *)lineViewDown
{
    if (!_lineViewDown) {
        CGFloat lineX = 0;
        CGFloat lineY = self.pickerView.st_bottom;
        CGFloat lineW = self.contentView.st_width;
        CGFloat lineH = 0.5;
        _lineViewDown = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        [_lineViewDown setBackgroundColor:self.borderButtonColor];
    }
    return _lineViewDown;
}

#pragma mark - 视图初始化

- (void)setupUI {
    
    // 1.设置数据的默认值
    _title             = nil;
    _font              = [UIFont systemFontOfSize:15];
    _titleColor        = [UIColor whiteColor];
    _borderButtonColor = [UIColor colorWithRed:205/255.0f green:205/255.0f blue:205/255.0f alpha:1.f];
    _headBackColor = [UIColor ZJ_green];
    _heightPickerComponent = 35;
    
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.contentMode == JKPickerContentModeBottom) {
        
    }else {
        self.buttonLeft.st_y = self.lineViewDown.st_bottom + JKMarginSmall;
        self.buttonRight.st_y = self.lineViewDown.st_bottom + JKMarginSmall;
    }
}


#pragma mark - --- setters 属性 ---

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.labelTitle setText:title];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self.buttonLeft.titleLabel setFont:font];
    [self.buttonRight.titleLabel setFont:font];
    [self.labelTitle setFont:font];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self.labelTitle setTextColor:titleColor];
    [self.buttonLeft setTitleColor:titleColor forState:UIControlStateNormal];
    [self.buttonRight setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setBorderButtonColor:(UIColor *)borderButtonColor
{
    _borderButtonColor = borderButtonColor;
    [self.buttonLeft addBorderColor:borderButtonColor];
    [self.buttonRight addBorderColor:borderButtonColor];
}

-(void)setHeadBackColor:(UIColor *)headBackColor{
    _headBackColor = headBackColor;
    self.headBackView.backgroundColor = headBackColor;
}

-(void)setPickerTypeMode:(JKPickerTypeMode)pickerTypeMode{
    _pickerTypeMode = pickerTypeMode;
    if (pickerTypeMode == JKPickerTimeType) {
        _openTime = 1;
        _startTime = 1;
        self.maxTime = 30;
        self.typeStr = @"小时";
    }else if (pickerTypeMode == JKPickerMonthType) {
        _openTime = 1;
        _startTime = 1;
        self.maxTime = 12;
        self.typeStr = @"个月";
    }else if (pickerTypeMode == JKPickerHourType) {
        _openTime = 4;
        _startTime = 4;
        self.maxTime = 24;
        self.typeStr = @"个小时";
    }
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.headBackView];
    [self.contentView addSubview:self.pickerView];
    [self.contentView addSubview:self.upLineImage];
    [self.contentView addSubview:self.downLineImage];
    [self.contentView addSubview:self.buttonLeft];
    [self.contentView addSubview:self.buttonRight];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.lineViewDown];
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.maxTime-self.startTime+1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.openTime = row+self.startTime;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%zd%@", row +self.startTime,self.typeStr];
    }
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}
#pragma mark - 事件相应

-(void)selectedCancel{
    [self remove];
}

- (void)selectedOk
{
    if (self.timeClickBlock) {
        self.timeClickBlock(self.openTime);
    }
    [self remove];
}



@end
