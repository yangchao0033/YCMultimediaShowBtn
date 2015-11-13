//
//  YCMultimediaShowBtn.m
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/9.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import "YCMultimediaShowBtn.h"
#import "YCPhotoBrowser.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YCAudioPlayer.h"
#import <LxDBAnything.h>


typedef NS_ENUM(NSUInteger, YCMultimediaShowBtnType) {
    YCMultimediaShowBtnTypeImage, // 图片
    YCMultimediaShowBtnTypeVoice, // 声音
    YCMultimediaShowBtnTypeVideo // 视频
};

@interface YCMultimediaShowBtn ()

@property (nonatomic, assign) YCMultimediaShowBtnType mediaType;
@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerVC;

@end

@implementation YCMultimediaShowBtn

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpInterface];
}

- (instancetype)initWithShowOnVC:(UIViewController *)vc filePath:(NSString *)path
{
    if (self = [super init]) {
//        LxDBAnyVar([self getDateTimeTOMilliSeconds]);
        LxDBAnyVar([self getDateTimeTOMilliSeconds:[NSDate date]]);
        self.showOnVC = vc;
        self.filePath = path;
        [self setUpInterface];
    }
    return self;
}

//将时间戳转换为NSDate类型
-(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    NSLog(@"传入的时间戳=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

//将NSDate类型的时间转换为时间戳,从1970/1/1开始
-(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    NSLog(@"转换的时间戳=%f",interval);
    long long totalMilliseconds = interval*1000 ;
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}

- (void)setUpInterface {
    [self addTarget:self action:@selector(mediaBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDelete:)]];
}

+ (instancetype)multimediaShowBtnWithVc:(UIViewController *)vc filePath:(NSString *)path
{
    YCMultimediaShowBtn *btn = [[self alloc] initWithShowOnVC:vc filePath:path];
    return btn;
}

- (void)setFilePath:(NSString *)filePath
{
    _filePath = [filePath copy];
    NSURL *pathUrl = [NSURL fileURLWithPath:filePath];
    NSString *lastComponent = [pathUrl lastPathComponent];
    if ([lastComponent containsString:@".jpg"] || [lastComponent containsString:@".png"] || [lastComponent containsString:@".JPG"] || [lastComponent containsString:@".PNG"]) {
        [self setBackgroundImage:[UIImage imageWithContentsOfFile:self.filePath] forState:(UIControlStateNormal)];
        self.hidden = NO;
        _mediaType = YCMultimediaShowBtnTypeImage;
    } else if ([lastComponent containsString:@".mov"] || [lastComponent containsString:@".MOV"]) {
        _mediaType = YCMultimediaShowBtnTypeVideo;
        [self setBackgroundImage:[UIImage imageNamed:@"video_slt"] forState:(UIControlStateNormal)];
        self.hidden = NO;
    } else if ([lastComponent containsString:@".mp3"] || [lastComponent containsString:@".wav"]){
        _mediaType = YCMultimediaShowBtnTypeVoice;
        [self setBackgroundImage:[UIImage imageNamed:@"sound_slt"] forState:(UIControlStateNormal)];
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
}

/** 长按手势 */
- (void)longPressDelete:(UILongPressGestureRecognizer *)ges {
    
}

/** 加事件 */
- (void)mediaBtnClick:(YCMultimediaShowBtn *)btn
{
    switch (_mediaType) {
        case YCMultimediaShowBtnTypeImage:
            [self handleImage];
            break;
        case YCMultimediaShowBtnTypeVideo:
            [self handleVideo];
            break;
        case YCMultimediaShowBtnTypeVoice:
            [self handleVoice];
            break;
    }
}
/** 处理图片 */
- (void)handleImage {
    [YCPhotoBrowser showBtn:self forState:(UIControlStateNormal) isBackGroundImage:YES];
}
/** 处理视频 */
- (void)handleVideo {
    [self openmovie];
    
}
/** 处理声音 */
- (void)handleVoice {
    //从budle路径下读取音频文件　　Katy Perry - Roar 这个文件名是你的歌曲名字,mp3是你的音频格式
//    NSString *string = [[NSBundle mainBundle] pathForResource:@"Katy Perry - Roar" ofType:@"mp3"];
//    把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:self.filePath];
    YCAudioPlayer *player = [YCAudioPlayer audioPlayerWithUrl:url];
    CGRect frame = CGRectMake(5, [UIScreen mainScreen].bounds.size.height / 2 , [UIScreen mainScreen].bounds.size.width - 10, 180);
    [player showPlayerWithPlayerFrameOnWindow:frame];
}

//打开本地视频：
-(void)openmovie
{
    MPMoviePlayerViewController *playerViewController  = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:self.filePath]];
    self.moviePlayerVC = playerViewController;
    // Remove the movie player view controller from the "playback did finish" notification observers
    [[NSNotificationCenter defaultCenter] removeObserver:playerViewController
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:[playerViewController moviePlayer]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:[playerViewController moviePlayer]];
    
    //    [[UIApplication sharedApplication].keyWindow addSubview:playerViewController.view];
    //    [self.showOnVC addChildViewController:self.moviePlayerVC];
    //    [];
    playerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    [self.showOnVC presentMoviePlayerViewControllerAnimated:playerViewController];
    //    playerViewController.view.frame = self.showOnVC.view.frame;//全屏播放（全屏播放不可缺）
//        playerViewController.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;//全屏播放（全屏播放不可缺）
    
    MPMoviePlayerController *player = [playerViewController moviePlayer];
    [player prepareToPlay];
    [player play];
    
}

// 视频结束后通知
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];
    
    [player pause];
    
    int value = [[aNotification.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    if (value == MPMovieFinishReasonUserExited) {
        [player stop];
        [self.showOnVC dismissMoviePlayerViewControllerAnimated];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:[self.moviePlayerVC moviePlayer]];
}

@end
