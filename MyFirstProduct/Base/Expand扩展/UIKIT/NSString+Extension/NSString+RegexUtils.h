//
//  NSString+RegexUtils.h
//  ZJDemoFrameworkTemplate
//
//  Created by kunge on 2017/7/11.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegexUtils)

//判断是否是中文
- (BOOL)isChinese;
//完整拼音
- (NSString *)pinyin;
//拼音首字母小写
- (NSString *)pinyinInitial;
//判断是否是邮箱
- (BOOL)isEmail;
//判断是否是手机号码
- (BOOL)isPhoneNumber;
- (BOOL)isDigit;
//判断是否是MAC地址
-(BOOL)isMACAddress;
//判断是否是数字
- (BOOL)isNumeric;
//判断是否是链接地址
- (BOOL)isUrl;
//判断是否是有效身份证号码
- (BOOL)isValidateIDCardNumber;
//6~20位字母和数字
-(BOOL)judgePassWord;
//6~16位字符
-(BOOL)judgePassWordLength;

@end
