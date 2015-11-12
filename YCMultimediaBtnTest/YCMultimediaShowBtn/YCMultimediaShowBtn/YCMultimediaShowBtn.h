//
//  YCMultimediaShowBtn.h
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/9.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YCMultimediaShowBtn : UIButton

/** YCMultimediaShowBtn所在的控制器,使用weak避免循环引用 */
@property (nonatomic, weak) IBOutlet UIViewController *showOnVC;
/** 多媒体资源所在路径 */
@property (nonatomic, copy) IBOutlet NSString *filePath;

/** 快速创建给定vc */
- (instancetype)initWithShowOnVC:(UIViewController *)vc filePath:(NSString *)path;

+ (instancetype)multimediaShowBtnWithVc:(UIViewController *)vc filePath:(NSString *)path;
@end
