//
//  JKPasswordKeyBoard.m
//  YuePoetryBridge
//
//  Created by kunge on 2018/6/8.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import "JKPasswordKeyBoard.h"

@interface UIView(keyboard)

- (CGFloat)getSupH;

@end

@implementation UIView(keyboard)

- (CGFloat)getSupH {
    NSMutableArray *svHs = [NSMutableArray array];
    for (UIView *sv in self.subviews) {
        [svHs addObject:@(CGRectGetMaxY(sv.frame))];
    }
    
    CGFloat max = [[svHs valueForKeyPath:@"@max.doubleValue"] floatValue];
    return max;
}

@end


@interface JKPasswordKeyBoard()

//键盘视图
@property (weak, nonatomic) IBOutlet UIView *boardView;
//显示密码的视图
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *dotViews;
//键盘视图的y(用于动画)
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomY;
//键盘按钮的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBtnH;
//密码显示视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordH;

@property (nonatomic, copy) NSMutableArray *numbers;

@end

@implementation JKPasswordKeyBoard

+ (instancetype) keyboard {
    JKPasswordKeyBoard *keyboard = [[NSBundle mainBundle] loadNibNamed:@"JKPasswordKeyBoard" owner:nil options:nil].firstObject;
    keyboard.frame = [UIScreen mainScreen].bounds;
    keyboard.hidden = YES;
    keyboard.passwordH.constant *= [UIScreen mainScreen].bounds.size.width/375;
    keyboard.keyBtnH.constant *= [UIScreen mainScreen].bounds.size.width/375;
    keyboard.bottomY.constant = -[keyboard.boardView getSupH];
    return keyboard;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
}

- (void)showKeyboard{
    self.hidden = NO;
    _numbers = [NSMutableArray array];
    _bottomY.constant = 0;
    [self handleDot];
    [UIView animateWithDuration:.35 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)hideKeyboard {
    _bottomY.constant = -[_boardView getSupH];
    [UIView animateWithDuration:.35 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (IBAction)cancelAction {
    [self hideKeyboard];
}

- (IBAction)back:(id)sender {
    [self hideKeyboard];
}

- (IBAction)keyBtnTap:(UIButton *)sender {
    NSString *str = [NSString stringWithFormat:@"%ld",sender.tag - 200];
    [_numbers addObject:str];
    [self handleDot];
    if (_numbers.count == _dotViews.count) {
        NSString *password = [_numbers componentsJoinedByString:@""];
        if (_completeBlock) {
            _completeBlock(password);
        }
        [self hideKeyboard];
    }
}

- (IBAction)deleteNum:(id)sender {
    if (_numbers.count > 0) {
        [_numbers removeObjectAtIndex:_numbers.count - 1];
        [self handleDot];
    }
}

- (void)handleDot {
    [_dotViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self->_numbers.count) {
            obj.hidden = NO;
        }
        else {
            obj.hidden = YES;
        }
    }];
}

@end
