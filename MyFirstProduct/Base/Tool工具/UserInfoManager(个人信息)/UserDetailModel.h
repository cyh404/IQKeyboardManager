//
//  UserDetailModel.h
//  TexasPoker
//
//  Created by 冯华恒 on 2018/7/18.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailModel : NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * isAdmin;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * qqOpenId;
@property (nonatomic , assign) NSInteger               sex;
@property (nonatomic , copy) NSString              * accountState;
@property (nonatomic , assign) NSInteger               userType;
@property (nonatomic , copy) NSString              * weiboOpenId;
@property (nonatomic , copy) NSString              * balance;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * password;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * gold;
@property (nonatomic , copy) NSString              * registerTime;
@property (nonatomic , copy) NSString              * wxOpenId;
@property (nonatomic , copy) NSString              * authCode;

@end
