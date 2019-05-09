//
//  HX_AddPhotoView.h
//  测试
//
//  Created by 洪欣 on 16/8/18.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    SelectPhoto,
    SelectVideo,
    SelectPhotoAndVieo
}SelectType;

@protocol HX_AddPhotoViewDelegate <NSObject>

@optional

- (void)updateViewFrame:(CGRect)frame;

@end

@interface HX_AddPhotoView : UIView

@property (assign, nonatomic) NSInteger lineNum;
@property (copy, nonatomic) void(^selectPhotos)(NSArray *array,BOOL ifOriginal);
@property (weak, nonatomic) id<HX_AddPhotoViewDelegate> delegate;

/**
 *  num : 最大限制
 *  type: 选择的类型
 */
- (instancetype)initWithMaxPhotoNum:(NSInteger)num WithSelectType:(SelectType)type;

-(void)endData;

@end
