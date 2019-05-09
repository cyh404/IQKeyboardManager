//
//  JKLocationManger.m
//  AoBoRui
//
//  Created by kunge on 2016/12/19.
//  Copyright © 2016年 kunge. All rights reserved.
//
//  定位只支持iOS8以后->

#import "JKLocationManager.h"

#define isIOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

@interface JKLocationManager ()<CLLocationManagerDelegate>{
    UIAlertController *AV;
}

/** 定位block对象 */
@property (nonatomic, copy) ResultLocationInfoBlock locationBlock;

/** 定位管理者 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 逆地理编码管理者 */
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation JKLocationManager

//单例对象
static JKLocationManager *_instance;
+ (JKLocationManager *)sharedJKLocationManager
{
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark - 懒加载
-(CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        if (isIOS(8)) {
            //在此处请求授权
            //1.获取项目配置->plist文件
            NSDictionary *infoPlistDict = [[NSBundle mainBundle] infoDictionary];
            //2.获取当前项目中的定位权限设置
            NSString *always = [infoPlistDict objectForKey:@"NSLocationAlwaysUsageDescription"];
            NSString *whenInUse = [infoPlistDict objectForKey:@"NSLocationWhenInUseUsageDescription"];
            //如果开发者设置后台定位模式->
            if (always.length > 0) {
                [_locationManager requestAlwaysAuthorization];
            }else if (whenInUse.length > 0){
                [_locationManager requestWhenInUseAuthorization];
                // 在前台定位授权状态下, 必须勾选后台模式location udpates才能获取用户位置信息
                NSArray *services = [infoPlistDict objectForKey:@"UIBackgroundModes"];
                if (![services containsObject:@"location"]) {
                    NSLog(@"友情提示: 当前状态是前台定位授权状态, 如果想要在后台获取用户位置信息, 必须勾选后台模式 location updates");
                }else{
                    if (isIOS(9.0)) {
                        _locationManager.allowsBackgroundLocationUpdates = YES;
                    }
                }
            }else{
                NSLog(@"错误---如果在iOS8.0之后定位, 必须在info.plist, 配置NSLocationWhenInUseUsageDescription 或者 NSLocationAlwaysUsageDescription");
            }
        }
    }
    return _locationManager;
}

-(CLGeocoder *)geocoder{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (JKLocationInfoModel *)locationInfoModel{
    if (_locationInfoModel==nil) {
        _locationInfoModel = [JKLocationInfoModel mj_objectWithKeyValues:UNGetObject(@"LocationInfo")];
    }
    return _locationInfoModel;
}

/**
 *  直接通过代码块获取用户位置信息
 *
 *  @param block 定位block代码块
 */
-(void)getCurrentLocation:(ResultLocationInfoBlock)block onViewController:(UIViewController *)viewController{
    //记录代码块
    self.locationBlock = block;
    //定位更新频率->
    [self.locationManager setDistanceFilter:100];
    //判断当前定位权限->进而开始定位
    [self startLocationOnViewController:viewController];
}

//定位
-(void)startLocationOnViewController:(UIViewController *)viewController{
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        dispatch_async(dispatch_get_main_queue(), ^{
//            AV = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位服务当前可能尚未打开，请设置打开！" preferredStyle:UIAlertControllerStyleAlert];
//            [AV addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//            [AV addAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                    [[UIApplication sharedApplication] openURL: url];
//                }
//                [_locationManager startUpdatingLocation];
//            }]];
//            [viewController presentViewController:AV animated:YES completion:nil];
        });
        return;
    }
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways ){
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }else{
        // 跳转核心代码
        dispatch_async(dispatch_get_main_queue(), ^{
//            AV = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位服务当前可能尚未打开，请设置打开！" preferredStyle:UIAlertControllerStyleAlert];
//            [AV addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//            [AV addAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                    [[UIApplication sharedApplication] openURL: url];
//                }
//                [_locationManager startUpdatingLocation];
//            }]];
//            [viewController presentViewController:AV animated:YES completion:nil];
        });
    }
}

#pragma mark - CLLocationManagerDelegate 
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    //表示水平准确度，这么理解，它是以coordinate为圆心的半径，返回的值越小，证明准确度越好，如果是负数，则表示corelocation定位失败。
    if (location.horizontalAccuracy < 0) {
        NSLog(@"location.horizontalAccuracy:%f,定位失败!!!!",location.horizontalAccuracy);
        return;
    }else{
        // 在这里, 还没获取地理位置, 获取到地标对象, 所以, 在此处, 要进一步进行反地理编码
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error == nil) {
                // 获取地标对象
                CLPlacemark *placemark = [placemarks firstObject];
                // 在此处, 最适合, 执行存储的代码块
                self.locationBlock(location, placemark, nil);
                JKLocationInfoModel *locationModel = [[JKLocationInfoModel alloc] init];
                locationModel.lat = location.coordinate.latitude;
                locationModel.lng = location.coordinate.longitude;
                locationModel.addressDictionary = placemark.addressDictionary;
                locationModel.city = placemark.addressDictionary[@"City"];
                locationModel.detailAddress = placemark.addressDictionary[@"FormattedAddressLines"];
                locationModel.currentAddress = placemark.name;
                locationModel.postalCode = placemark.postalCode;
                [self saveLocationInfoWithModel:locationModel];
                
            }else{
                self.locationBlock(location, nil, error.localizedDescription);
            }
        }];
    }
    //停止定位->
    [_locationManager stopUpdatingLocation];
}

#pragma mark - 数据存储和清空
-(void)saveLocationInfoWithModel:(JKLocationInfoModel *)locationInfoModel{
    [self clearLocationInfo];
    UNSaveObject([locationInfoModel mj_keyValues], @"LocationInfo");
    NSLog(@"locationInfoModel==%@",[locationInfoModel mj_keyValues]);
    self.locationInfoModel = nil;
}

-(void)clearLocationInfo{
    _locationInfoModel = nil;
    UNSaveObject(@"", @"LocationInfo");
}


@end
