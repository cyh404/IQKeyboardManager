//
//  BaseIAPViewController.m
//  HongDouTV
//
//  Created by MinSen on 2016/12/8.
//  Copyright © 2016年 MinSen. All rights reserved.
//

/*
 服务器验证的时候注意：
 测试时应该使用地址：https://sandbox.iTunes.Apple.com/verifyReceipt ,
 生产环境地址：https://buy.itunes.apple.com/verifyReceipt .
 */


#import "BaseIAPViewController.h"
#import <UIImage+GIF.h>
#import <MBProgressHUD.h>

@interface BaseIAPViewController ()<MBProgressHUDDelegate>

@property (nonatomic ,copy) void(^sucBlock)(void);

@property (nonatomic, strong) MBProgressHUD    * loadingHud;
@end

@implementation BaseIAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configIAP];
}

- (void)configIAP
{
    _iapHelper = [RMIAPHelper sharedInstance];
    _iapHelper.delegate = self;
    
    [_iapHelper setup];
}

- (void)topUpMoneySucBlock:(void(^)(void))sucBlock
{
    _sucBlock = sucBlock;
}


 


/***********************************************************************/
/***********************************************************************/

#pragma mark - IAP_Delegate -
#pragma mark - Delegate -
// 商品请求失败
- (void)requestProduct:(RMIAPHelper*)sender startFail:(SKRequest*)request error:(NSError *)error
{
    [self hideLoading];
    [[UIApplication sharedApplication].keyWindow showMsg:error.localizedDescription];
}

- (void)paymentRequest:(RMIAPHelper*)sender purchased:(SKPaymentTransaction*)transaction
{
    NSLog(@"交易成功");
    
    NSData *data = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] appStoreReceiptURL] path]];
    self.receipt = [data base64EncodedStringWithOptions:0];
    
    //验证订单
    [self network_URL_Pay_IOSVerify];
}

- (void)paymentRequest:(RMIAPHelper*)sender restored:(SKPaymentTransaction*)transaction
{
    NSLog(@"恢复交易");
    SKPayment * payment = transaction.originalTransaction.payment;
    NSLog(@"恢复购买的 id: %@",[payment productIdentifier]);
    [_iapHelper restore];
}

- (void)paymentRequest:(RMIAPHelper*)sender failed:(SKPaymentTransaction*)transaction
{
    NSLog(@"交易失败");
    [self hideLoading];
    
    if (transaction.error.code == SKErrorPaymentCancelled) {
        NSLog(@"用户取消充值");
        [self.view showMsg:@"您已取消该充值"];
    }else if (transaction.error.code == SKErrorCloudServiceNetworkConnectionFailed){
        NSLog(@"连接网络失败");
        [self.view showMsg:@"连接商品服务器失败"];
    }else if (transaction.error.code == SKErrorStoreProductNotAvailable){
        NSLog(@"产品还不可用");
    }else if (transaction.error.code == SKErrorUnknown){
        NSLog(@"未知错误");
        [[UIApplication sharedApplication].keyWindow showMsg:transaction.error.localizedDescription];
    }
    NSLog(@"交易失败信息: %@",transaction.error.localizedDescription);
}

// 恢复
- (BOOL)restoredArray:(RMIAPHelper*)sender withArray:(NSArray*)productsIdArray{
    return YES;
}

// 不支持内购
- (void)iapNotSupported:(RMIAPHelper*)sender
{
    [self hideLoading];
    
    NSLog(@"不允许程序内付费购买");
    ALERT(@"您的手机没有打开程序内付费购买", nil);
   
}

/***********************************************************************/
/***********************************************************************/

#pragma mark - OtherMethods -



/***********************************************************************/
/***********************************************************************/
/***********************************************************************/

#pragma mark -
#pragma mark - 记录订单
- (void)network_URL_Pay_IOSVerify{
    // 网络请求验证支付结果
    // 后台去验证
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"order_num"] = self.orderNum;
    param[@"receipt"]  = self.receipt;
    
   // post请求
}

@end
