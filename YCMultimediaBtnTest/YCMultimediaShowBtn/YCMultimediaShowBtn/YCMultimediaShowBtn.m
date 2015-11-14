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
        self.showOnVC = vc;
        self.filePath = path;
        [self setUpInterface];
    }
    return self;
}


- (void)setUpInterface {
    [self addTarget:self action:@selector(mediaBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
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

- (void)setLongPressEnable:(BOOL)longPressEnable
{
    _longPressEnable = longPressEnable;
    if (self.longPressEnable) {
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDelete:)]];
    }
}

/** 长按手势 */
- (void)longPressDelete:(UILongPressGestureRecognizer *)ges {
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            if ([self.delegate respondsToSelector:@selector(mutimediaShowBtn:longPressBeganAtFilePath:)]) {
                [self.delegate mutimediaShowBtn:self longPressBeganAtFilePath:self.filePath];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if ([self.delegate respondsToSelector:@selector(mutimediaShowBtn:longPressEndedAtFilePath:)]) {
                [self.delegate mutimediaShowBtn:self longPressEndedAtFilePath:self.filePath];
            }
            break;
        default:
            break;
    }
\
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
    player.playRecordVoice = self.playRecordVoice;
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
