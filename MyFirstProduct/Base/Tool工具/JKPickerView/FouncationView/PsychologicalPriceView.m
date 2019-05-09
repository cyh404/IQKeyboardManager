//
//  PsychologicalPriceView.m
//  XinNongTongApp
//
//  Created by kunge on 2017/9/27.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import "PsychologicalPriceView.h"

@interface PsychologicalPriceView()<UIPickerViewDataSource, UIPickerViewDelegate>


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


@property(nonatomic,strong)UIView *selectBackView;
@property (nonatomic, assign)NSMutableArray *fristPriceArr;
@property (nonatomic, assign)NSMutableArray *secondPriceArr;
@property(nonatomic,strong)NSString *frsitStr;
@property(nonatomic,strong)NSString *secondStr;

@end

@implementation PsychologicalPriceView

-(NSMutableArray *)fristPriceArr{
    if (_fristPriceArr == nil) {
        _fristPriceArr = [NSMutableArray array];
        float temp = 0.1;
        for (int i = 0; i < 99; i++) {
            temp+=0.1;
            [_fristPriceArr addObject:[NSString stringWithFormat:@"%f",temp]];
        }
    }
    return _fristPriceArr;
}

-(NSMutableArray *)secondPriceArr{
    if (_secondPriceArr == nil) {
        _secondPriceArr = [NSMutableArray array];
        float temp = 10.1;
        for (int i = 0; i < 99; i++) {
            temp+=0.1;
            [_secondPriceArr addObject:[NSString stringWithFormat:@"%f",temp]];
        }
    }
    return _secondPriceArr;
}

#pragma mark -  视图初始化

- (void)setupUI {
    
    // 1.设置数据的默认值
    _title             = nil;
    _font              = [UIFont systemFontOfSize:15];
    _titleColor        = [UIColor ZJ_b40000Color];
    _borderButtonColor = [UIColor colorWithRed:205/255.0f green:205/255.0f blue:205/255.0f alpha:1.f];
    _headBackColor = [UIColor ZJ_WhiteColor];
    
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.headBackView];
    [self.contentView addSubview:self.pickerView];
    [self.contentView addSubview:self.buttonLeft];
    [self.contentView addSubview:self.buttonRight];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.lineViewDown];
    
    _heightPickerComponent = 28;
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];

    
    for (UIView *subView in self.pickerView.subviews) {
        if(subView.subviews.count){
            UIView *contentView = subView.subviews[0];
            for (UIView *contentSubView in contentView.subviews) {
                if(contentSubView.center.y == contentView.center.y){
                    if(_selectBackView != contentSubView){
                        _selectBackView.backgroundColor = [UIColor clearColor];
                        _selectBackView = contentSubView;
                        _selectBackView.backgroundColor = [UIColor redColor];
                    }
                    break;
                }
            }
            break;
        }
    }
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
    //    [self.labelTitle setTextColor:titleColor];
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

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _fristPriceArr.count;
    }else if(component == 1) {
        return _secondPriceArr.count;
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            _frsitStr = _fristPriceArr[row];
            [pickerView reloadComponent:1];
            break;
        case 1:
            _secondStr = _secondPriceArr[row];
            [pickerView reloadComponent:2];
        default:
            break;
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%@",_fristPriceArr[row]];
    }else if (component == 1){
        text =  [NSString stringWithFormat:@"%@",_secondPriceArr[row]];
    }
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    label.textColor = [UIColor ZJ_b40000Color];
    return label;
}

#pragma mark - 事件相应
-(void)selectedCancel{
    [self remove];
}

- (void)selectedOk
{
    if (self.pricePickBlock) {
        self.pricePickBlock(_frsitStr,_secondStr);
    }
    [self remove];
}

#pragma mark - --- private methods 私有方法 ---
- (void)reloadData
{
    
}

#pragma mark - --- setters 属性 ---
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

-(UIImageView *)upLineImage{
    if (!_upLineImage) {
        _upLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 1)];
        _upLineImage.center = CGPointMake(_pickerView.center.x, _pickerView.center.y-20);
        _upLineImage.backgroundColor = [UIColor ZJ_b40000Color];
    }
    return _upLineImage;
}

-(UIImageView *)downLineImage{
    if (!_downLineImage) {
        _downLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 1)];
        _downLineImage.center = CGPointMake(_pickerView.center.x, _pickerView.center.y+20);
        _downLineImage.backgroundColor = [UIColor ZJ_b40000Color];
    }
    return _downLineImage;
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
        [_labelTitle setTextColor:[UIColor ZJ_666666Color]];
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

@end
