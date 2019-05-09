//
//  UserinfoManager.h
//  EasyEducation
//
//  Created by 杜子腾 on 16/6/13.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserinfoModel.h"
#import "UserDetailModel.h"
@interface UserinfoManager : NSObject

@property(strong,nonatomic)UserinfoModel *userModel;
@property(strong,nonatomic)UserDetailModel *userDetailModel;
@property(strong,nonatomic)NSString *receiver;
@property(strong,nonatomic)NSString *views;

@property(strong,nonatomic)NSString *tokens;

+ (instancetype)sharedData;

-(void)setTokenAction:(NSString *)tokens;

-(void)saveUserInfoWithDict:(NSDictionary *)dict;

-(void)clearUserInfo;
//退出登录
-(void)logout;

@end
