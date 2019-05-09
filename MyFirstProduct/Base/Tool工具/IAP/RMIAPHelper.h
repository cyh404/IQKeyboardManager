//
//  RMIAPHelper.h
//  BookCat
//
//  Created by rm-imac on 14-4-18.
//
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <StoreKit/SKPaymentTransaction.h>


@class RMIAPHelper;
@protocol RMIAPHelperDelegate <NSObject>

@optional
// 商品请求成功
- (void)requestProduct:(RMIAPHelper*)sender startSuccess:(SKRequest*)request;
// 商品请求失败
- (void)requestProduct:(RMIAPHelper*)sender startFail:(SKRequest*)request error:(NSError *)error;

#pragma mark - 购买
// 商品请求
- (void)requestProduct:(RMIAPHelper*)sender start:(SKProductsRequest*)request;
// 商品请求结果回调
- (void)requestProduct:(RMIAPHelper*)sender received:(SKProductsRequest*)request;
// 当前商品
- (void)paymentRequest:(RMIAPHelper*)sender start:(SKPayment*)payment;
// 商品交易成功
- (void)paymentRequest:(RMIAPHelper*)sender purchased:(SKPaymentTransaction*)transaction;
// 恢复商品
- (void)paymentRequest:(RMIAPHelper*)sender restored:(SKPaymentTransaction*)transaction;
// 交易失败
- (void)paymentRequest:(RMIAPHelper*)sender failed:(SKPaymentTransaction*)transaction;

// 恢复
- (BOOL)restoredArray:(RMIAPHelper*)sender withArray:(NSArray*)productsIdArray;

// 其他
// 不支持内购
- (void)iapNotSupported:(RMIAPHelper*)sender;
@end

@interface RMIAPHelper : NSObject

+(RMIAPHelper*)sharedInstance;

@property(nonatomic,assign) id<RMIAPHelperDelegate> delegate;

-(void)setup;
-(void)destroy;
-(void)buy:(NSString*)productId;

-(void)restore;
@end
