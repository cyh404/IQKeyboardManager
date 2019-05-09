//
//  UserinfoManager.m
//  EasyEducation
//
//  Created by 杜子腾 on 16/6/13.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "UserinfoManager.h"
#import "MJExtension.h"

static UserinfoManager *sharedInstance = nil;

@implementation UserinfoManager
+ (instancetype)sharedData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self class] new];
    });
    return sharedInstance;
}

- (UserinfoModel *)userModel{
    if (!_userModel) {
        NSLog(@"====%@",UNGetObject(@"UserInfo"));
       _userModel = [UserinfoModel mj_objectWithKeyValues:UNGetObject(@"UserInfo")];
    }
    return _userModel;
}
-(void)setTokenAction:(NSString *)tokens
{
    _tokens=tokens;
 
    [[NSUserDefaults standardUserDefaults] setObject:tokens forKey:@"UserInfoToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)tokens
{
    if (!_tokens) {
//
        _tokens=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfoToken"];
    }
    return _tokens;
}
#pragma mark - Method
-(void)saveUserInfoWithDict:(NSDictionary *)dict{
    [self clearUserInfo];
    _userModel = [UserinfoModel mj_objectWithKeyValues:dict];
    
    UNSaveObject(_userModel.mj_keyValues, @"UserInfo");
    NSLog(@"dict==%@",_userModel.mj_keyValues);
    
      NSLog(@"====%@",UNGetObject(@"UserInfo"));
    self.userModel = nil;
}


-(void)clearUserInfo{
    _userModel = nil;
    UNSaveObject(@"", @"UserInfo");
     NSLog(@"====%@",UNGetObject(@"UserInfo"));
}



@end
