//
//  ViewController.m
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/9.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import "ViewController.h"
#import "YCMultimediaShowBtn.h"
#import <LxDBAnything.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet YCMultimediaShowBtn *imageIcon;
@property (weak, nonatomic) IBOutlet YCMultimediaShowBtn *voiceBtn;
@property (weak, nonatomic) IBOutlet YCMultimediaShowBtn *vedioBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    self.imageIcon.filePath = imagePath;
    LxDBAnyVar(self.imageIcon.imageView);
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"testMOV" ofType:@"mov"];
    self.vedioBtn.filePath = videoPath;
    self.vedioBtn.showOnVC = self;
    
     NSString *voicePath = [[NSBundle mainBundle] pathForResource:@"Katy Perry - Roar" ofType:@"mp3"];
    self.voiceBtn.filePath = voicePath;
    self.vedioBtn.showOnVC = self;
    
//    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"testMOV" ofType:@"mov"];
    
    
    /** 缓存到数组中，防止被误修改 */
    NSArray *tempFilePaths = @[imagePath, voicePath, videoPath];
    CGFloat margin = 10;
    CGFloat btnH = 60;
    CGFloat startOffsetX = 100;
    CGFloat startOffsetY = 100;
    [tempFilePaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat btnX = idx * (btnH + margin);
        YCMultimediaShowBtn *btn = [YCMultimediaShowBtn multimediaShowBtnWithVc:self filePath:(NSString *)obj];
        btn.frame = CGRectMake(startOffsetX + btnX, startOffsetY, btnH, btnH);
        [self.view addSubview:btn];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"testMOV" ofType:@"mov"];
//    MPMoviePlayerViewController *playerViewController  = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:videoPath]];
//    [self presentMoviePlayerViewControllerAnimated:playerViewController];
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
//    self.voiceBtn.filePath = imagePath;
//    self.view.backgroundColor = [UIColor redColor];
//    self.vedioBtn.showOnVC = self;
}


@end
