//
//  TestTVCell.h
//  MyFirstProduct
//
//  Created by cyh on 2018/11/25.
//  Copyright © 2018年 cyh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BlockTest)(void);
@interface TestTVCell : UITableViewCell
@property (strong,nonatomic) BlockTest testClick;
@end
