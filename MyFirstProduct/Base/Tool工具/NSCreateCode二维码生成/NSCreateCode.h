
//二维码、条形码图片生成

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef enum {
    QrCode = 0,
    BarCode =1
} CodeType;

@interface NSCreateCode : NSObject

/**
 *  生成码图片
 *  @param codeStr        网络请求的接口
 *  @param imageView      图片视图
 *  @param codeType       0为二维码、1为条形码
 */
+ (UIImage *)createCode:(NSString *)codeStr imageView:(UIView *)imageView codeType:(CodeType)codeType;


@end
