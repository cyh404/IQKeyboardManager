//
//  ChooseAddressView.m
//  WIFIEarnMoney
//
//  Created by 冯华恒 on 2017/3/8.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import "ChooseAddressView.h"
#import "PlistInfoModel.h"

@interface ChooseAddressView()

//省 数组
@property (strong, nonatomic) NSMutableArray *provinceArr;
//城市 数组
@property (strong, nonatomic) NSMutableArray *cityArr;


/**
 *  选中的省市区
 */
@property(nonatomic,strong) NSString *province;

@property(nonatomic,strong) NSString *city;

@property(nonatomic,strong) NSString *provinceCode;

@property(nonatomic,strong) NSString *cityCode;

@end

@implementation ChooseAddressView

-(NSMutableArray *)provinceArr{
    if (_provinceArr == nil) {
        _provinceArr = [NSMutableArray array];
    }
    return _provinceArr;
}

-(NSMutableArray *)cityArr{
    if (_cityArr == nil) {
        _cityArr = [NSMutableArray array];
    }
    return _cityArr;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    _bgView.backgroundColor = [UIColor ZJ_shelterColor];
    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)]];
    
    [self requestPlist];
    
}

#pragma mark 获取省列表
-(void)requestPlist{
    NSDictionary *paramDict = @{
                                };
    ZJLog(@"paramDict==%@",paramDict);
    [self showLoading];
//    [[ZJNetworkManager shareNetworkManager] POSTWithURL:URL_PersonCenter_plist Parameter:paramDict success:^(NSDictionary *resultDic) {
//        ZJLog(@"resultDic=====%@",resultDic);
//        if (SuccessCode) {
//            [self.provinceArr removeAllObjects];
//            self.provinceArr = [PlistInfoModel mj_objectArrayWithKeyValuesArray:resultDic[@"data"]];
//            if (!kArrayIsEmpty(self.provinceArr)) {
//                [self reloadPlistWithIndex:0];
//            }
//        }else{
//            [self showToast:ErrorToast];
//            ZJLog(@"错误提示：%@",ErrorToast);
//        }
//        [self hideLoading];
//    } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *description) {
//        [self hideLoading];
//    }];
}

#pragma mark 获取市列表
-(void)requestClistwithPid:(NSString *)pid{
    NSDictionary *paramDict = @{
                                @"pid":pid
                                };
    ZJLog(@"paramDict==%@",paramDict);
//    [self showLoading];
//    [[ZJNetworkManager shareNetworkManager] POSTWithURL:URL_PersonCenter_clist Parameter:paramDict success:^(NSDictionary *resultDic) {
//        ZJLog(@"resultDic=====%@",resultDic);
//        if (SuccessCode) {
//            [self.cityArr removeAllObjects];
//            self.cityArr = [PlistInfoModel mj_objectArrayWithKeyValuesArray:resultDic[@"data"]];
//            if (!kArrayIsEmpty(self.cityArr)) {
//                [self reloadClistWithIndex:0];
//                [self.pickerView reloadAllComponents];
//            }
//        }else{
//            [self showToast:ErrorToast];
//            ZJLog(@"错误提示：%@",ErrorToast);
//        }
//        [self hideLoading];
//    } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *description) {
//        [self hideLoading];
//    }];
}

-(void)reloadPlistWithIndex:(NSInteger)index{
    PlistInfoModel *plistInfoModel = self.provinceArr[index];
    self.province = plistInfoModel.name;
    self.provinceCode = plistInfoModel._id;
    [self requestClistwithPid:self.provinceCode];
}

-(void)reloadClistWithIndex:(NSInteger)index{
    PlistInfoModel *plistInfoModel = self.cityArr[0];
    self.city = plistInfoModel.name;
    self.cityCode = plistInfoModel._id;
}

-(void)hideAction
{
    self.hidden=YES;
}

- (IBAction)okAction:(id)sender {
    if (self.backAddressInfoBlock) {
        self.backAddressInfoBlock(self.province,self.provinceCode,self.city,self.cityCode);
    }
    [self hideAction];
}

- (IBAction)cancelAction:(id)sender {
    [self hideAction];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.provinceArr.count;
            break;
        case 1:
            return self.cityArr.count;
            break;
        default:
            return 0;
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            PlistInfoModel *plistInfoModel = self.provinceArr[row];
            return plistInfoModel.name;
        }
            break;
        case 1:
        {
            PlistInfoModel *clistInfoModel = self.cityArr[row];
            return clistInfoModel.name;
        }
            break;
        default:
            return  @"";
            break;
    }
    return @"";
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.textColor = [UIColor ZJ_blue];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            [self reloadPlistWithIndex:row];
        }
            break;
        case 1:
        {
            [self reloadClistWithIndex:row];
        }
            break;
        default:
            break;
    }
}

@end
