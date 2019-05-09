//
//  ChooseAddressView.h
//  WIFIEarnMoney
//
//  Created by 冯华恒 on 2017/3/8.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseAddressView : UIView

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (nonatomic,copy) void (^backAddressInfoBlock)(NSString *province,NSString *provinceCode,NSString *city,NSString *cityCode);


@end
