//
//  NSDate+YCExtension.h
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/13.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YCExtension)
/*!
*  @author 杨超, 15-11-13 17:11:10
*
*  @brief  将时间戳转换为NSDate类型
*
*  @param miliSeconds 毫秒时间
*
*  @return 返回NSData对象
*
*  @since <#version number#>
*/
+(instancetype)getDateTimeFromMilliSeconds:(long long) miliSeconds;
/*!
 *  @author 杨超, 15-11-13 17:11:32
 *
 *  @brief  将NSDate类型的时间转换为时间戳,从1970/1/1开始
 *
 *  @return 返回时间戳
 *
 *  @since <#version number#>
 */
-(long long)getDateTimeTOMilliSeconds;
@end
