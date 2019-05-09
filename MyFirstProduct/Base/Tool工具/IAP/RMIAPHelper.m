//
//  RMIAPHelper.m
//  BookCat
//
//  Created by rm-imac on 14-4-18.
//
//

#import "RMIAPHelper.h"
@interface RMIAPHelper()<SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    BOOL  _isOpenObser;
}

@property (nonatomic, weak)   SKPaymentQueue* paymentQueue;  
@end

@implementation RMIAPHelper

static RMIAPHelper*    _instance = NULL;

+(RMIAPHelper*)sharedInstance
{
    if(_instance == nil)
    {
        _instance = [[RMIAPHelper alloc]init];
    }
    return _instance;
}

+ (void)release
{
    [_instance destroy];
    _instance = nil;
}

- (void)setup
{
    if (_isOpenObser) return;
    
    _paymentQueue = [SKPaymentQueue defaultQueue];
    //监听SKPayment过程
    [_paymentQueue addTransactionObserver:self];
    NSLog(@"RMIAPHelper 开启交易监听");
    
    _isOpenObser = YES;
}

- (void)destroy
{
    //解除监听
    if (_paymentQueue) {
        [_paymentQueue removeTransactionObserver:self];
        _paymentQueue = nil;
    }
    NSLog(@"RMIAPHelper 注销交易监听");
    _isOpenObser = NO;
}

- (BOOL)canMakePayments{
    return [SKPaymentQueue canMakePayments];
}

- (void)buy:(NSString*)productId
{
    NSLog(@" 请求商品ID ———— %@",productId);
//    [HUD_Helper loading];
    if([self canMakePayments]){
       [self requestProduct:productId];
    }else{
        NSLog(@"不支持内购");
        [self.delegate iapNotSupported:self];
    }
}

- (void)requestProduct:(NSString*)productId
{
    NSArray *product = [[NSArray alloc] initWithObjects:productId,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    request.delegate = self;
    [request start];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestProduct:startSuccess:)]) {
        [self.delegate requestProduct:self startSuccess:request];
    }
}

#pragma mark SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestProduct:received:)]) {
        [self.delegate requestProduct:self received:request];
    }
    
    
    NSLog(@"didReceiveResponse called:");
    NSLog(@"prodocuId:%@",response.products);
    NSLog(@"=======================================================");
    
    NSArray *productArray = response.products;
    if(productArray != nil && productArray.count > 0)
    {
        SKProduct *product = [productArray objectAtIndex:0];
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
        
        SKPayment* payment = [SKPayment paymentWithProduct:product];
        [_paymentQueue addPayment:payment];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(paymentRequest:start:)]) {
            [self.delegate paymentRequest:self start:payment];
        }
    }
}

#pragma mark SKPaymentTransactionObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    NSLog(@"updatedTransactions called:");
    NSMutableArray* restoreArray = [[NSMutableArray alloc]init];
    for(SKPaymentTransaction* transaction in transactions)
    {
        NSLog(@"%@",transaction.payment.productIdentifier);
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing: //商品添加进列表
                NSLog(@"添加商品进购买列表");
                break;
            case SKPaymentTransactionStatePurchased: //交易成功
                [self.delegate paymentRequest:self purchased:transaction];
                [_paymentQueue finishTransaction:transaction];
                
                break;
            case SKPaymentTransactionStateRestored: //已购买过该商品,恢复购买
                [restoreArray addObject:transaction.payment.productIdentifier];
                [self.delegate paymentRequest:self restored:transaction];
                [_paymentQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed: //交易失败
                [self.delegate paymentRequest:self failed:transaction];
                [_paymentQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateDeferred://交易延迟
                break;
            default:
                break;
        }
    }
    if(restoreArray.count > 0)
    {
        [self.delegate restoredArray:self withArray:restoreArray];
    }
    NSLog(@"=======================================================");
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"请求商品失败 __ %@",error.localizedDescription);
    [self.delegate requestProduct:self startFail:request error:error];
}

- (void)requestDidFinish:(SKRequest *)request
{
    NSLog(@"请求商品成功");
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestProduct:startSuccess:)]) {
        [self.delegate requestProduct:self startSuccess:request];
    }
}

//交易完成之后，调用； 据我理解应该是[_paymentQueue finishTransaction:transaction]; 调用成功之后的回掉
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    NSLog(@"removedTransactions called:");
    NSLog(@"transactions __ %@",transactions);
    NSLog(@"=======================================================");
}

//恢复失败
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"restoreCompletedTransactionsFailedWithError called:");
    NSLog(@"error:%@",error);
    NSLog(@"=======================================================");
}

// Sent when all transactions from the user's purchase history have successfully been added back to the queue.
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished called:");
    NSLog(@"SKPaymentQueue:%@",queue);
    NSLog(@"=======================================================");
}
// Sent when the download state has changed.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads
{
    NSLog(@"updatedDownloads called:");
    NSLog(@"=======================================================");
}

#pragma 恢复流程
//发起恢复
-(void)restore
{
    [_paymentQueue restoreCompletedTransactions];
}

@end
