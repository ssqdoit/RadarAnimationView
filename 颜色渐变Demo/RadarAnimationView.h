//
//  RadarAnimationView.h
//  颜色渐变Demo
//
//  Created by 时双齐 on 16/5/13.
//  Copyright © 2016年 亿信互联. All rights reserved.
//

typedef void(^RaderBtnBlock)();
typedef void(^RaderBtnSelectBlock)();

#import <UIKit/UIKit.h>

//雷达效果
@interface RadarAnimationView : UIView

/**
 *  按钮图片
 */
@property (nonatomic ,strong) UIImage *image;
/**
 *  按钮选中颜色
 */
@property (nonatomic ,strong) UIImage *selectImage;
/**
 *  波纹颜色
 */
@property (nonatomic,strong) UIColor *raderColor;

/**
 *  按钮block  未选择状态
 */
@property (nonatomic,copy) RaderBtnBlock block;
/**
 *  按钮block  选择状态
 */
@property (nonatomic,copy) RaderBtnSelectBlock selectBlock;

@end
