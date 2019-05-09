
//二维码、条形码图片生成

#import "NSCreateCode.h"

@implementation NSCreateCode

+ (UIImage *)createCode:(NSString *)codeStr imageView:(UIView *)imageView codeType:(CodeType)codeType
{
    NSCreateCode *codeTemp = [[NSCreateCode alloc] init];
    CIImage *image  = [codeTemp createQRForString:codeStr codeType:codeType];
    CGSize size = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
    UIImage *result = [codeTemp createNonInterpolatedUIImageFormCIImage:image withSize:size];
    return result;
}

- (CIImage *)createQRForString:(NSString *)qrString codeType:(CodeType)codeType{
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // @"CICode128BarcodeGenerator"  条形码
    // @"CIQRCodeGenerator"       二维码
    // 创建filter
    NSString *filterName = nil;
    if (codeType == QrCode) {
        filterName = @"CIQRCodeGenerator";
    }else if (codeType == QrCode) {
        filterName = @"CICode128BarcodeGenerator";
    }
    CIFilter *qrFilter = [CIFilter filterWithName:filterName];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return qrFilter.outputImage;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGSize)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    UIImage *result = [UIImage imageWithCGImage:scaledImage];
    
    CGColorSpaceRelease(cs);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGImageRelease(scaledImage);
    return result;
}

@end
