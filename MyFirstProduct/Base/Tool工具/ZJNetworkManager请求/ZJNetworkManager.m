//
//  ZJNetworkManager.m
//  Shuweiuser
//
//  Created by kunge on 2017/7/10.
//  Copyright © 2017年 zijing. All rights reserved.
//

#import "ZJNetworkManager.h"
#import "Reachability.h"


@implementation ZJNetworkManager
{
    int pp;
}
#pragma mark -  单例类初始化
+ (instancetype)shareNetworkManager
{
    static ZJNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.afManager = [AFHTTPSessionManager manager];
        //设置超时时间
        instance.afManager.requestSerializer.timeoutInterval = 20;
        instance.afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                    @"text/html",
                                                                    @"text/json",
                                                                    @"text/javascript",
                                                                    @"text/plain",
                                                                    @"application/text",
                                                                    nil];
        
        //设置证书模式
//        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"wifi" ofType:@"cer"];
//        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//        instance.afManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
//        // 客户端是否信任非法证书
//        instance.afManager.securityPolicy.allowInvalidCertificates = YES;
//        // 是否在证书域字段中验证域名
//        [instance.afManager.securityPolicy setValidatesDomainName:NO];
        
    });
    return instance;
}

#pragma mark - body方式请求
/**
 *  异步POST请求:以body方式,支持数组
 *
 *  @param url     请求的url
 *  @param body    参数字典
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)RequestBodyWithUrl:(NSString *)url requestType:(ZJRequestType)requestType body:(NSDictionary *)body success:(SuccessBlock)success failure:(void(^)(NSError *error))failure
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", DomainURL, url];
    ZJLog(@"请求链接为：----%@,请求参数字典为：------%@",requestUrl,body);
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSArray *typeArr = @[@"GET",@"POST",@"PUT",@"DELETE"];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:typeArr[requestType] URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval = 20;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:ShareSessionId forHTTPHeaderField:@"authentication"];
    
    // 设置body
    if (requestType != GETType) {
        [request setHTTPBody:[[body mj_JSONString] mj_JSONData]];
    }
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *resultDict = [responseObject mj_JSONObject];
            [self dealWithReturnData:resultDict];
            if ([resultDict[@"code"] integerValue] == 0) {
                success(resultDict[@"msg"]);
            }else{
                ZJLog(@"请求失败，结果为：-----%@,错误提示为：-----%@",resultDict,resultDict[@"msg"]);
            }
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } else {
            failure(error);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }] resume];
}

#pragma mark - POST请求
- (void)POSTWithURL:(NSString *)url Parameter:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    url = [NSString stringWithFormat:@"%@%@",DomainURL,url];
    //设置sessionID作为HeaderField
//    [self.afManager.requestSerializer setValue:[UserinfoManager sharedData].userModel.authentication forHTTPHeaderField:@"authentication"];
    
//    NSLog(@"请求url = %@  参数 = %@,sessionId===%@",url,param,[UserinfoManager sharedData].userModel.authentication);
    
    [self.afManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [self.afManager.requestSerializer setValue:@"application/json, text/plain, */*" forHTTPHeaderField:@"Accept"];
    
    [self.afManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求结果: %@",responseObject);
        NSDictionary *dict = responseObject;
        [self dealWithReturnData:dict];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=====请求失败=====%@",error);
        failure(task , error,@"");
        if (![self isExistenceNetwork]) {
            failure(task,error,@"网络有问题，请稍后再试");
        }else{
            failure(task , error,@"");
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

#pragma mark - GET请求
- (void)GETWithURL:(NSString*)url Parameter:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure
{
    url = [NSString stringWithFormat:@"%@%@",DomainURL,url];
    NSLog(@"请求url = %@  参数 = %@",url,param);
    
    //设置sessionID作为HeaderField
//    [self.afManager.requestSerializer setValue:[UserinfoManager sharedData].userModel.token forHTTPHeaderField:@"token"];
    [self.afManager.requestSerializer setValue:@"tk18819457945" forHTTPHeaderField:@"token"];
    
    [self.afManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回参数 = %@ ",responseObject);
        NSDictionary *dict = responseObject;
        [self dealWithReturnData:dict];
        success(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=====请求失败=====%@",error);
        failure(task , error,@"");
    }];
}

#pragma mark - UPLOAD请求
#pragma mark 上传单张图片
- (void)UPLOADImage:(UIImage *)image progress:(void (^)(CGFloat))progressBlock success:(SuccessBlock)success failure:(FailureBlock)failure{
    if (image == nil) {
        [MBProgressHUD showWithMessage:@"图片为空"];
        return;
    }
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@",DomainURL,URL_commonUpload];
//    NSLog(@"URLString====%@,ShareSessionId===%@",URLString,ShareSessionId);
//    [self.afManager.requestSerializer setValue:[UserinfoManager sharedData].userModel.authentication forHTTPHeaderField:@"authentication"];
    
    [self.afManager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"file.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = responseObject;
        if (SuccessCode) {
            success(responseObject);
        }else{
            [MBProgressHUD showWithMessage:resultDic[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showWithMessage:@"上传失败"];
        failure(task , error,@"");
    }];
}

#pragma mark 上传doc文件
- (void)UPLOADDoc:(NSData *)docData progress:(void (^)(CGFloat))progressBlock success:(SuccessBlock)success failure:(FailureBlock)failure{
    if (docData == nil) {
        [MBProgressHUD showWithMessage:@"文件为空"];
        return;
    }
    
//    NSString *URLString = [NSString stringWithFormat:@"%@%@",DomainURL,URL_Login_uploadFile];
//    NSLog(@"URLString====%@,sessionId===%@",URLString,ShareSessionId);
//    [self.afManager.requestSerializer setValue:[UserinfoManager sharedData].userModel.authentication forHTTPHeaderField:@"authentication"];
    
//    [self.afManager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:docData name:@"file" fileName:@"file.doc" mimeType:@"application/msword"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *resultDic = responseObject;
//        if (SuccessCode) {
//            success(responseObject);
//        }else{
//            [MBProgressHUD showWithMessage:resultDic[@"message"]];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD showWithMessage:@"上传失败"];
//        failure(task , error,@"");
//    }];
}

#pragma mark AFNetworking上传图片请求
- (void)AFUPLOADImageWithUrl:(NSString *)url Parameter:(NSDictionary *)param updata:(UploadDataBlock)uploadDataBlock success:(SuccessBlock)success failure:(FailureBlock)failure
{
    url = [NSString stringWithFormat:@"%@%@",DomainURL,url];
    NSLog(@"请求url = %@  参数 = %@",url,param);
    [self.afManager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        uploadDataBlock(formData);
        uploadDataBlock(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        [self dealWithReturnData:dict];
        success(responseObject);
        NSLog(@"返回参数 = %@ ",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=====请求失败=====%@",error);
        failure(task , error,@"");
    }];
}

#pragma mark - 网络状态以及返回数据处理
- (ZJNetWorkState )ZJNetWorkState
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NSLog(@"  ====:%zd",[r currentReachabilityStatus]);
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            self.ZJNetWorkState = ZJNetWorkStateNone;
            break;
        case ReachableViaWWAN:
            // 手机网络
            self.ZJNetWorkState = ZJNetWorkStatePhone;
            break;
        case ReachableViaWiFi:
            // WiFi网络
            self.ZJNetWorkState = ZJNetWorkStateWifi;
            break;
    }
    return self.ZJNetWorkState;
}

#pragma mark 检测网络状态
- (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork = false;
    Reachability *reachAblitity = [Reachability reachabilityForInternetConnection];
    switch ([reachAblitity currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            break;
    }
    return isExistenceNetwork;
}

#pragma mark 返回数据状态码判断
-(void)dealWithReturnData:(NSDictionary *)dic{
    //sessionId失效重新登录
   
    if ([dic[@"info"] isEqualToString:@"登录信息已过期"]) {
 
        if (pp==0) {
            pp=1;
             [[NSNotificationCenter defaultCenter] postNotificationName:RELOGIN object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                pp= 0;
            });
        }
       
        
    }
}

#pragma mark 获取随机字符
-(NSString *)randomStringWithLength:(int)len{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

#pragma mark 获取当前时间戳
-(NSString *)getDateTimeString{
    NSDateFormatter *formatter;
    NSString        *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}

@end
