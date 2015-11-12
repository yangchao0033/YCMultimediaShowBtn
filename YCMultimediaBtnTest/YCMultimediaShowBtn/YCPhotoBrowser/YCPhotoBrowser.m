//
//  YCPhotoBrowser.m
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/9.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import "YCPhotoBrowser.h"
static CGRect oldframe;
@implementation YCPhotoBrowser
+(void)showImage:(UIImageView *)imageView{
    UIImage *image=imageView.image;
    [self showWithImage:image fromView:imageView];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

/** btn的方法 */
+(void)showBtn:(UIButton *)avatarBtn forState:(UIControlState)controlState isBackGroundImage:(BOOL)isBack{
    UIImage *image= isBack ? [avatarBtn backgroundImageForState:controlState] : [avatarBtn imageForState:controlState];
    [self showWithImage:image fromView:avatarBtn];
    
}

//+ (void)hideBtn:(UITapGestureRecognizer*)tap{
//    UIView *backgroundView=tap.view;
//    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
//    [UIView animateWithDuration:0.3 animations:^{
//        imageView.frame=oldframe;
//        backgroundView.alpha=0;
//    } completion:^(BOOL finished) {
//        [backgroundView removeFromSuperview];
//    }];
//}

+ (void)showWithImage:(UIImage *)image fromView:(UIView *)fromeView
{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[fromeView convertRect:fromeView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}
@end
