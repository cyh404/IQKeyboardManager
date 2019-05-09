//
//  UIView+Convience.h
//  FixJob
//
//  Created by terry_ash on 1/12/16.
//  Copyright © 2016 terry_ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Convience)

- (void)showMsg:(NSString *) msg;

-(void)showToast:(NSString *)string;

- (void)showErr:(NSError *) err;

- (void)fj_showErrorMsg:(NSError *) error;

- (void)showLoading;

- (void)hideLoading;
- (void)showMsg:(NSString *)msg Black:(void(^)(void))black;

@end
