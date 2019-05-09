//
//  TestTVCell.m
//  MyFirstProduct
//
//  Created by cyh on 2018/11/25.
//  Copyright © 2018年 cyh. All rights reserved.
//

#import "TestTVCell.h"

@implementation TestTVCell



- (IBAction)testAction:(UIButton *)sender {
    if (_testClick) {
        _testClick();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
