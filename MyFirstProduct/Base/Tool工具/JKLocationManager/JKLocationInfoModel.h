//
//  JKLocationInfoModel.h
//  AoBoRui
//
//  Created by kunge on 2017/1/9.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKLocationInfoModel : NSObject

@property double lat;//纬度
@property double lng;//经度

/*
 CLPlacemark相关属性
 */
//地址全称
/*
 City = "\U5e7f\U5dde\U5e02";
 Country = "\U4e2d\U56fd";
 CountryCode = CN;
 FormattedAddressLines =     (
 "\U4e2d\U56fd\U5e7f\U4e1c\U7701\U5e7f\U5dde\U5e02\U5929\U6cb3\U533a\U68e0\U4e0b\U8857\U9053\U68e0\U4e0b\U9ad8\U6c99\U88572\U53f7"
 );
 Name = "\U6b63\U8fbe\U5199\U5b57\U697c";
 State = "\U5e7f\U4e1c\U7701";
 Street = "\U68e0\U4e0b\U9ad8\U6c99\U88572\U53f7";
 SubLocality = "\U5929\U6cb3\U533a";
 Thoroughfare = "\U68e0\U4e0b\U9ad8\U6c99\U88572\U53f7";
 */
@property(nonatomic,strong)NSDictionary *addressDictionary;
//城市
@property(nonatomic,strong)NSString *city;
//详细地址
@property(nonatomic,strong)NSString *detailAddress;
//当前地址（如：正达写字楼）
@property(nonatomic,strong)NSString *currentAddress;
//邮编
@property(nonatomic,strong)NSString *postalCode;

@end
