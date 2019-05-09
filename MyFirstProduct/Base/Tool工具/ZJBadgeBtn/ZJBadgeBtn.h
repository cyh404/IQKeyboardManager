//
//  ZJBadgeBtn.h
//  PearlRiverSeec
//
//  Created by kunge on 2017/12/22.
//  Copyright © 2017年 kunge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBadgeBtn : UIButton

@property(nonatomic,strong)UIImageView *dotImage;
@property (nonatomic,retain)UILabel * badgeLabel;
@property (nonatomic,copy)NSString * badgeString;
@property (nonatomic,assign)BOOL isShowDot;

@end
