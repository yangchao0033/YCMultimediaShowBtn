//
//  NSDate+YCExtension.m
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/13.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import "NSDate+YCExtension.h"

@implementation NSDate (YCExtension)
//将时间戳转换为NSDate类型
+(instancetype)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    NSLog(@"传入的时间戳=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

//将NSDate类型的时间转换为时间戳,从1970/1/1开始
-(long long)getDateTimeTOMilliSeconds
{
    NSTimeInterval interval = [self timeIntervalSince1970];
    NSLog(@"转换的时间戳=%f",interval);
    long long totalMilliseconds = interval*1000 ;
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}
@end
