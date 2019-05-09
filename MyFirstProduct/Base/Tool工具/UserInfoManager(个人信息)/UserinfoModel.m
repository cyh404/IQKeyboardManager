//
//  UserinfoModel.m
//  EasyEducation
//
//  Created by 杜子腾 on 16/6/13.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "UserinfoModel.h"

@implementation UserinfoModel

+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"_id": @"id"
             ,@"_descriptionsss":@"description"};
}
-(void)setHeadicon:(NSString *)headicon
{
    if ([headicon hasPrefix:@"http"]) {
        _headicon=headicon;
    }else
    {
        _headicon=[NSString stringWithFormat:@"%@%@",PicURL,headicon];
    }
}
@end
