//
//  UIViewController+CameraOrPhoto.h
//  TaoWeiDao
//
//  Created by 吕金状 on 15/10/10.
//  Copyright (c) 2015年 吕金状. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CameraOrPhoto)<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

- (UIImagePickerController *)imagePickerController;
/**
 *  调用相册
 */
- (void)showActionSheet;
- (void)useCamera;
- (void)usePhoto;


@end
