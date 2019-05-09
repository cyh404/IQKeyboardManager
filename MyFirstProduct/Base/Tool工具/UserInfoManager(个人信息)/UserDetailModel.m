
//
//  UserDetailModel.m
//  TexasPoker
//
//  Created by 冯华恒 on 2018/7/18.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import "UserDetailModel.h"

@implementation UserDetailModel
-(void)setAvatar:(NSString *)avatar
{
    if ([avatar hasPrefix:@"http"]) {
        _avatar=avatar;
    }else
    {
        _avatar=[NSString stringWithFormat:@"%@%@",DomainURL,avatar];
    }
}
@end
