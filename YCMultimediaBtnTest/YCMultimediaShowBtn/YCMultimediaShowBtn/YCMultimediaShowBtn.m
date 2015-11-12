//
//  YCMultimediaShowBtn.m
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/9.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import "YCMultimediaShowBtn.h"
#import "YCPhotoBrowser.h"
#import "LxDBAnything.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "YCAudioPlayer.h"
#import "YCPlayerViewController.h"


typedef NS_ENUM(NSUInteger, YCMultimediaShowBtnType) {
    YCMultimediaShowBtnTypeImage, // 图片
    YCMultimediaShowBtnTypeVoice, // 声音
    YCMultimediaShowBtnTypeVideo // 视频
};

@interface YCMultimediaShowBtn ()

@property (nonatomic, assign) YCMultimediaShowBtnType mediaType;
@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerVC;
@property (nonatomic, strong) UITapGestureRecognizer *showVCGes;
@property (nonatomic, strong) AVPlayer *AVPlayer;
@property (nonatomic, assign) BOOL isVideoPlaying;
@end

@implementation YCMultimediaShowBtn

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

//- (instancetype)init
//{
//    if (self = [super init]) {
//        self = [self initWithShowOnVC:_showOnVC filePath:_filePath];
//    }
//    return self;
//}

- (instancetype)initWithShowOnVC:(UIViewController *)vc filePath:(NSString *)path
{
    if (self = [super init]) {
        self.showOnVC = vc;
        self.filePath = path;
    }
    return self;
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
        _mediaType = YCMultimediaShowBtnTypeImage;
    } else if ([lastComponent containsString:@".mov"] || [lastComponent containsString:@".MOV"]) {
        _mediaType = YCMultimediaShowBtnTypeVideo;
    } else {
        _mediaType = YCMultimediaShowBtnTypeVoice;
    }
    [self addTarget:self action:@selector(mediaBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
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
//    [self openmovieWithAVPlayer];
//    [self openmovieWithYCPlayerViewController];
    
}
/** 处理声音 */
- (void)handleVoice {
    //从budle路径下读取音频文件　　Katy Perry - Roar 这个文件名是你的歌曲名字,mp3是你的音频格式
//    NSString *string = [[NSBundle mainBundle] pathForResource:@"Katy Perry - Roar" ofType:@"mp3"];
    //把音频文件转换成url格式
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:[playerViewController moviePlayer]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:[playerViewController moviePlayer]];
    
//    [[UIApplication sharedApplication].keyWindow addSubview:playerViewController.view];
//    [self.showOnVC addChildViewController:self.moviePlayerVC];
//    [];
    playerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
//    [self.showOnVC presentViewController:playerViewController animated:YES completion:^{
//    
//    }];
    

    [self.showOnVC presentMoviePlayerViewControllerAnimated:playerViewController];
//    playerViewController.view.frame = self.showOnVC.view.frame;//全屏播放（全屏播放不可缺）
//    playerViewController.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;//全屏播放（全屏播放不可缺）
    
    MPMoviePlayerController *player = [playerViewController moviePlayer];
    [player prepareToPlay];
    [player play];
    
}

-(void)openmovieWithAVPlayer
{
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:self.filePath];
    
    AVAsset *movieAsset	= [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerFinishedCallBack:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.showOnVC.view.layer.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.showOnVC.view.layer addSublayer:playerLayer];
//    [player play];
//    self.isVideoPlaying = !self.isVideoPlaying;
    self.AVPlayer = player;
    self.showVCGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoTaped:)];
    self.showVCGes.numberOfTapsRequired = 2;
    [self.showOnVC.view addGestureRecognizer:self.showVCGes];

}

- (void)openmovieWithYCPlayerViewController {
    YCPlayerViewController *vc = [[UIStoryboard storyboardWithName:NSStringFromClass([YCPlayerViewController class]) bundle:nil] instantiateInitialViewController];
//    vc.player
    
    [self.showOnVC presentViewController:vc animated:YES completion:^{
        
    }];
}
- (void)videoTaped:(UITapGestureRecognizer *)ges {
    if (self.isVideoPlaying) {
        [self.AVPlayer pause];
        self.isVideoPlaying = NO;
    } else {
        [self.AVPlayer play];
        self.isVideoPlaying = YES;
    }
}

- (void)AVPlayerFinishedCallBack:(NSNotification *)no {
    LxDBAnyVar(__func__);
//    [];
    self.isVideoPlaying = NO;
    
    [self.AVPlayer.currentItem seekToTime:kCMTimeZero];
}

// 视频结束后通知
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];

    [player pause];
    
    int value = [[aNotification.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    if (value == MPMovieFinishReasonUserExited) {
        [self.showOnVC dismissMoviePlayerViewControllerAnimated];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification  object:self.AVPlayer.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:[self.moviePlayerVC moviePlayer]];
}
@end
