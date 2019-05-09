//
//  UIView+Convience.m
//  FixJob
//
//  Created by terry_ash on 1/12/16.
//  Copyright © 2016 terry_ash. All rights reserved.
//

#import "UIView+Convience.h"
#import <MBProgressHUD.h>
#import "AppDelegate.h"
#import <SVProgressHUD.h>
#define kAshViewConenceHudTag 93929L

@implementation UIView (Convience)
- (void)showMsg:(NSString *)msg Black:(void(^)(void))black{
    NSLog(@"%@,%s",msg,__func__);
    [self hideLoading];
    if (msg.length > 0) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
        hud.mode = MBProgressHUDModeText;
        NSRange range = [msg rangeOfString:@"（"];
        if (range.length > 0) {
            msg = [msg substringToIndex:range.location];
        }
        hud.label.text = msg;
        
        NSLog(@"%@",msg);
        [self addSubview:hud];
        
        [hud showAnimated:NO whileExecutingBlock:^{
            [NSThread sleepForTimeInterval:1.8];
        } completionBlock:^{
            [hud removeFromSuperViewOnHide];
            black();
        }];
    }
}
- (void)showMsg:(NSString *)msg{
    NSLog(@"%@,%s",msg,__func__);
    [self hideLoading];
    if (msg.length > 0) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
        hud.mode = MBProgressHUDModeText;
        NSRange range = [msg rangeOfString:@"（"];
        if (range.length > 0) {
            msg = [msg substringToIndex:range.location];
        }
        hud.label.text = msg;

        NSLog(@"%@",msg);
        [self addSubview:hud];
        [hud showAnimated:NO whileExecutingBlock:^{
            [NSThread sleepForTimeInterval:1.8];
        } completionBlock:^{
            [hud removeFromSuperViewOnHide];
        }];
    }
}

-(void)showToast:(NSString *)string{
    if (kStringIsEmpty(string)) {
        return;
    }
//    [MBProgressHUD hideHUDForView:self animated:YES];
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    if (string.length > 10) {
//        hud.detailsLabelText = string;
//    }else{
//        hud.label.text = string;
//    }
//    
//    [hud showAnimated:YES whileExecutingBlock:^{
//        sleep(1.0);
//    } completionBlock:^{
//        if ([[[UIApplication sharedApplication]windows] count] > 1) {
//            [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication]windows]objectAtIndex:1] animated:YES];
//        }else{
//            [MBProgressHUD hideHUDForView:self animated:YES];
//        }
//    }];
    
    
    [SVProgressHUD showInfoWithStatus:string];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
}

- (void)showLoading{
//    MBProgressHUD *hud = [self viewWithTag:kAshViewConenceHudTag];
//    if (nil == hud) {
//        hud = [[MBProgressHUD alloc] initWithView:self];
//        hud.tag = kAshViewConenceHudTag;
//        hud.label.text = @"加载中";
//        hud.label.textColor = [UIColor whiteColor];
//        [self addSubview:hud];
//    }
//    [hud showAnimated:YES];
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
    [SVProgressHUD show];
    
//    [MBProgressHUD showChrysanthemumOnView:self];
}

- (void)showErr:(NSError *)err{
    if ([err.localizedDescription length] > 0) {
         [self showMsg:err.localizedDescription];
    }
}

- (void)hideLoading{
//    MBProgressHUD *hud = [self viewWithTag:kAshViewConenceHudTag];
//    [hud hideAnimated:YES];
//    [hud removeFromSuperViewOnHide];
 [SVProgressHUD dismiss];
}

- (void)fj_showErrorMsg:(NSError *)error{
    NSString *msg =  error.localizedDescription;
    [self showMsg:msg];
}

@end
