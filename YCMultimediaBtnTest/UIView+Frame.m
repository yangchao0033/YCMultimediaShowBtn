//
//  UIView+Frame.m
//  Created by 李南江 on 15/3/1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

#pragma mark －自适应文本高度
/**
 width  文本宽度
 font   文本字体
 str    文本内容
 */
//- (CGFloat)AdaptiveTextHeightWithWidth:(CGFloat)width andFont:(UIFont *)font andStr:(NSString *)str{
//    
//    if ([str containsString:@"\n"]) {
//        
//        NSArray *strArr = [str componentsSeparatedByString:@"\n"];
//        
//        CGFloat allHeight = 0;
//        
//        for (int i = 0 ; i < strArr.count ; i ++ ) {
//            NSString *subStr = [strArr objectAtIndex:i];
//            
//            //CGFloat height = 0;
//            CGSize size;
//            if (IOS_VERSION > 7.0) {
//                NSDictionary *attributeDic = @{NSFontAttributeName:font};
//                CGRect rect = [subStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil];
//                size  = rect.size;
//            }else{
//                CGSize size1 = [subStr sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
//                size = size1;
//            }
//            
//            allHeight = allHeight + size.height;
//        }
//        
//        return allHeight;
//        
//    } else {
//        
//        CGFloat height;
//        
//        if (IOS_VERSION > 7.0) {
//            NSDictionary *attributeDic = @{NSFontAttributeName:font};
//            CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil];
//            height  = rect.size.height;
//        }else{
//            CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
//            height = size.height;
//        }
//        return height;
//        
//    }
//}

- (CGSize)AdaptiveStrHeightWithWidth:(CGFloat)width andFont:(UIFont *)font andStr:(NSString *)str{
    NSString * tstring = str;
    UIFont * tfont = font;
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    // label可设置的最大高度和宽度
    CGSize size =CGSizeMake(width,MAXFLOAT);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize;
}


@end
