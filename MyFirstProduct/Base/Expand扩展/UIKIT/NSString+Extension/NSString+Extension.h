//
//  NSString+Extension.h
//  ZiJingiOSBasicFrameWork
//
//  Created by kunge on 2017/2/6.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

//去掉无意义的0
+ (NSString *)stringDisposeWithFloatStringValue:(NSString *)floatStringValue;
+ (NSString *)stringDisposeWithFloatValue:(float)floatNum;
//千分位格式化数据
+ (NSString *)ittemThousandPointsFromNumString:(NSString *)numString;
//计算字符串的CGSize
- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
/*
 根据当前语言国际化
 */
+(NSString *)LanguageInternationalizationCH:(NSString *)Chinese EN:(NSString *)English;
/*
 给金额字符串添加分割标示，例：33，345，434.98
 */
+(NSString *)ResetAmount:(NSString *)Amount_str segmentation_index:(int)segmentation_index segmentation_str:(NSString *)segmentation_str;

/**
 *  md5加密
 */
- (NSString *)MD5string;
/**
 *  字符串添加图片
 */
-(NSMutableAttributedString *)insertImg:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect;
/**
 *  不同颜色不同字体大小字符串
 */
-(NSMutableAttributedString *)setOtherColor:(UIColor *)Color font:(CGFloat)font forStr:(NSString *)forStr;
/*
 在文字上添加删除线（例如过去的价格）
 */
-(NSAttributedString *)AddRemoveLineOnStringRange:(NSRange)range lineWidth:(NSInteger)lineWidth;
/*
 时间戳转标准时间
 */
+(NSString *)timestampSwitchTime:(NSInteger )timestamp andFormatter:(NSString *)format;
/*
 时间戳转多久之前
 */
+ (NSString *)timeBeforeInfoWithString:(NSTimeInterval)timeIntrval;
//去html
+ (NSString *)removeHTML:(NSString *)html;

//小数点后的数字变小
-(NSMutableAttributedString *)decimalPointAttributedString;
//¥符号变小
-(NSMutableAttributedString *)moneySymbolAttributedString;
//元字变小
-(NSMutableAttributedString *)yuanAttributedString;

-(NSString *)judgeEmptyBack;

+(NSMutableString *)webImageFitToDeviceSize:(NSMutableString *)strContent;


//[add]by ken at 2017年12月01日
/**规定宽度，计算文字面积*/
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

//改变同一个label中对应文字的字体大小和颜色
+ (NSMutableAttributedString *)attrStrFrom:(NSString *)totalStr dealStr:(NSString *)dealStr fontNum:(CGFloat)fontNum color:(UIColor *)color;

@end
