//
//  YCPhotoBrowser.h
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/9.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCPhotoBrowser : NSObject
/*!
 *  @author 杨超, 15-11-09 12:11:38
 *
 *  @brief  用于展示imageView单个图片
 *
 *  @param imageView 传入imageView
 *
 *  @since <#version number#>
 */
+(void)showImage:(UIImageView*)imageView;

/*!
 *  @author 杨超, 15-11-09 12:11:38
 *
 *  @brief  浏览按钮的单个图片
 *
 *  @param avatarBtn    传入的按钮
 *  @param controlState 按钮状态
 *  @param isBack       是否为背景image
 *
 *  @since <#version number#>
 */
+(void)showBtn:(UIButton *)avatarBtn forState:(UIControlState)controlState isBackGroundImage:(BOOL)isBack;
/*!
 *  @author 杨超, 15-11-09 12:11:12
 *
 *  @brief  展示并放大一个view上得image
 *
 *  @param image     图片image数据
 *  @param fromeView 需要放大的view
 *
 *  @since 1.0
 */
+ (void)showWithImage:(UIImage *)image fromView:(UIView *)fromeView;
@end
