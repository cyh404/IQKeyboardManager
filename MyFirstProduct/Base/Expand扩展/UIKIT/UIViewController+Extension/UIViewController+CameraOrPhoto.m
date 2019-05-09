//
//  UIViewController+CameraOrPhoto.m
//  XinJiYuan
//
//  Created by 吕金状 on 15/10/12.
//  Copyright © 2015年 bluemobi. All rights reserved.
//

#import "UIViewController+CameraOrPhoto.h"

@implementation UIViewController (CameraOrPhoto)

- (UIImagePickerController *)imagePickerController
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    [imagePickerController.navigationBar setBarTintColor:[UIColor colorWithRed:63/255.0 green:146/255. blue:244/255. alpha:1]];
    [imagePickerController.navigationBar setTintColor:[UIColor whiteColor]];
    [imagePickerController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    imagePickerController.editing = YES;
    imagePickerController.allowsEditing = YES;
    imagePickerController.navigationBar.translucent = NO;
    return imagePickerController;
}

- (void)showActionSheet
{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if(version >= 8.0f)
    {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *addPhoneAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self useCamera];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self usePhoto];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [actionSheet addAction:addPhoneAction];
        [actionSheet addAction:photoAction];
        [actionSheet addAction:cancelAction];
//        if (isPad) {
//            UIPopoverPresentationController *popPresenter = [actionSheet
//                                                             popoverPresentationController];
//            popPresenter.sourceView = self.view;
//            popPresenter.sourceRect = CGRectMake(20, 400, 200, 500);
//            [self presentViewController:actionSheet animated:YES completion:nil];
//        }else
        {
            [self presentViewController:actionSheet animated:true completion:nil];
        }
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相薄选择",@"拍照", nil];
        [actionSheet showInView:self.view];
#pragma clang diagnostic pop
        
    }
}

-(void)useCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self ;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [picker.navigationBar setBarTintColor:[UIColor colorWithRed:63/255.0 green:146/255. blue:244/255. alpha:1]];
        [picker.navigationBar setTintColor:[UIColor whiteColor]];
        [picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        picker.navigationBar.translucent = NO;
        [self presentViewController:picker animated:YES completion:nil];

    }else{
        //相册
        [self showMessage:@"当前设备无摄像头，请从相册获取"];
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

-(void)usePhoto
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

//选择相机时actionSheet点击事件

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //调用相机
    if (buttonIndex == 1)
    {
        [self useCamera];
    }
    else if (buttonIndex == 0)
    {
        [self usePhoto];
    }
}

- (void) showMessage:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:alert.cancelButtonIndex animated:YES];
    });
}


@end
