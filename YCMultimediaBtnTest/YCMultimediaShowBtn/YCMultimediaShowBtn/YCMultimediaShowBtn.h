//
//  YCMultimediaShowBtn.h
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/9.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCMultimediaShowBtn;

@protocol YCMultimediaShowBtnDelegate <NSObject>
@optional
/*!
 *  @author 杨超, 15-11-14 14:11:48
 *
 *  @brief  长按手势处理
 *
 *  @param btn      按钮
 *  @param filePath 路径
 *
 *  @since <#version number#>
 */
- (void)mutimediaShowBtn:(YCMultimediaShowBtn *)btn longPressBeganAtFilePath:(NSString *)filePath;
- (void)mutimediaShowBtn:(YCMultimediaShowBtn *)btn longPressEndedAtFilePath:(NSString *)filePath;
@end

@interface YCMultimediaShowBtn : UIButton

/** YCMultimediaShowBtn所在的控制器,使用weak避免循环引用 */
@property (nonatomic, weak) IBOutlet UIViewController *showOnVC;
/** 多媒体资源所在路径 */
@property (nonatomic, copy) IBOutlet NSString *filePath;
/** 知否支持长按手势 */
@property (nonatomic, assign) BOOL longPressEnable;
/** 是否在播放录音，默认为NO，播放录音时会进行音量调整，防止无法听见录音*/
@property (nonatomic, assign) BOOL playRecordVoice;

@property (nonatomic, weak) id<YCMultimediaShowBtnDelegate> delegate;

/** 快速创建给定vc */
- (instancetype)initWithShowOnVC:(UIViewController *)vc filePath:(NSString *)path;
+ (instancetype)multimediaShowBtnWithVc:(UIViewController *)vc filePath:(NSString *)path;
@end
