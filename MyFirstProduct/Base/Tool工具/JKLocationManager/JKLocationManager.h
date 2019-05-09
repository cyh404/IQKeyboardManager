//
//  JKLocationManger.h
//  AoBoRui
//
//  Created by kunge on 2016/12/19.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import "JKLocationInfoModel.h"

/**
 *  定位block块
 *
 *  @param location  当前位置对象
 *  @param placeMark 反地理编码对象
 *  @param error     错误信息
 */
typedef void(^ResultLocationInfoBlock)(CLLocation *location, CLPlacemark *placeMark, NSString *error);


@interface JKLocationManager : NSObject
//单例对象
+(JKLocationManager *)sharedJKLocationManager;

@property(strong,nonatomic)JKLocationInfoModel *locationInfoModel;

/**
 *  直接通过代码块获取用户位置信息
 *
 *  @param block 定位block代码块
 */
-(void)getCurrentLocation:(ResultLocationInfoBlock)block onViewController:(UIViewController *)viewController;

/**
 本地存储定位信息

 @param locationInfoModel 定位信息数据模型
 */
-(void)saveLocationInfoWithModel:(JKLocationInfoModel *)locationInfoModel;

/**
 清空本地定位信息
  */
-(void)clearLocationInfo;

@end
