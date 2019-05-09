//
//  ZJPhotoBrowserVC.h
//  ImageBrowser
//
//  Created by kunge on 2017/8/23.
//  Copyright © 2017年 msk. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 跳转方式
 */
typedef NS_ENUM(NSUInteger,PhotoBroswerVCType) {
    
    //modal
    PhotoBroswerVCTypePush=0,
    
    //push
    PhotoBroswerVCTypeModal,
    
    //zoom
    PhotoBroswerVCTypeZoom,
};

@interface ZJPhotoBrowserVC : UIViewController

/**
 *  显示图片
 */
+(void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index imagesBlock:(NSArray *(^)())imagesBlock;

@end
