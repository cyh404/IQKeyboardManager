//
//  BaseIAPViewController.h
//  HongDouTV
//
//  Created by MinSen on 2016/12/8.
//  Copyright © 2016年 MinSen. All rights reserved.
//

#import "BaseViewController.h"
#import "RMIAPHelper.h"

@interface BaseIAPViewController : BaseViewController<RMIAPHelperDelegate>

@property (nonatomic, readonly) RMIAPHelper    * iapHelper;

@property (nonatomic ,copy) NSString * receipt;
@property (nonatomic, copy) NSString   * orderNum;

- (void)topUpMoneySucBlock:(void(^)(void))sucBlock;


 
@end
