//
//  PlistInfoModel.m
//  EzsafePurchase
//
//  Created by kunge on 2018/5/28.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import "PlistInfoModel.h"

@implementation PlistInfoModel

+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"_id": @"id"};
}

@end
