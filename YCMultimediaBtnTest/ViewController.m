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
#import "UIView+Frame.h"


@interface ViewController ()<YCMultimediaShowBtnDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet YCMultimediaShowBtn *imageIcon;
@property (weak, nonatomic) IBOutlet YCMultimediaShowBtn *voiceBtn;
@property (weak, nonatomic) IBOutlet YCMultimediaShowBtn *vedioBtn;

@property (nonatomic, strong) NSMutableArray *tempFilePaths;
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, assign) NSInteger deleteBtnIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    self.imageIcon.delegate = self;
    self.imageIcon.filePath = imagePath;
    LxDBAnyVar(self.imageIcon.imageView);
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"testMOV" ofType:@"mov"];
    self.vedioBtn.delegate = self;
    self.vedioBtn.filePath = videoPath;
    self.vedioBtn.showOnVC = self;
    
     NSString *voicePath = [[NSBundle mainBundle] pathForResource:@"Katy Perry - Roar" ofType:@"mp3"];
    self.voiceBtn.delegate = self;
    self.voiceBtn.filePath = voicePath;
    self.vedioBtn.showOnVC = self;
    
    self.tempFilePaths = @[imagePath, voicePath, videoPath].mutableCopy;
    CGFloat margin = 10;
    CGFloat btnH = 60;
    CGFloat startOffsetX = 60;
    CGFloat startOffsetY = 100;
    self.btns = @[].mutableCopy;
    [self.tempFilePaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat btnX = idx * (btnH + margin);
        YCMultimediaShowBtn *btn = [YCMultimediaShowBtn multimediaShowBtnWithVc:self filePath:(NSString *)obj];
        btn.delegate = self;
        btn.longPressEnable = YES;
        btn.frame = CGRectMake(startOffsetX + btnX, startOffsetY, btnH, btnH);
        [self.view addSubview:btn];
        [self.btns addObject:btn];
        LxDBAnyVar(btn);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

- (void)mutimediaShowBtn:(YCMultimediaShowBtn *)btn longPressBeganAtFilePath:(NSString *)filePath
{
    LxDBAnyVar(__func__);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    alertView.delegate = self;
    alertView.tag = 1000 + [self.tempFilePaths indexOfObject:filePath];
    self.deleteBtnIndex = [self.tempFilePaths indexOfObject:filePath];
    [alertView show];
}

- (void)mutimediaShowBtn:(YCMultimediaShowBtn *)btn longPressEndedAtFilePath:(NSString *)filePath
{
    LxDBAnyVar(__func__);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    LxDBAnyVar(buttonIndex);
    if (buttonIndex == 1) {
        [self.tempFilePaths removeObject:self.tempFilePaths[alertView.tag - 1000]];
        [self reloadBtnsAnimated:YES];
    }
}

- (void)reloadBtnsAnimated:(BOOL)animate
{
    CGFloat margin = 10;
    CGFloat btnH = 60;
//    CGFloat startOffsetX = 100;
//    CGFloat startOffsetY = 100;
    
    
    /** 做动画 */
    /** 找到要删除的元素 */
    YCMultimediaShowBtn *animateBtn = self.btns[self.deleteBtnIndex];
    [animateBtn removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        for (int i = (int)self.deleteBtnIndex + 1; i < self.btns.count; ++i) {
            YCMultimediaShowBtn *btn = self.btns[i];
            btn.x -= btnH + margin;
        }
    } completion:^(BOOL finished) {
        /** 删除元素 */
        [self.btns removeObject:animateBtn];
    }];
//    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.btns removeAllObjects];
//    [self.tempFilePaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGFloat btnX = idx * (btnH + margin);
//        YCMultimediaShowBtn *btn = [YCMultimediaShowBtn multimediaShowBtnWithVc:self filePath:(NSString *)obj];
//        btn.delegate = self;
//        btn.longPressEnable = YES;
//        btn.frame = CGRectMake(startOffsetX + btnX, startOffsetY, btnH, btnH);
//        [self.btns addObject:btn];
//        [self.view addSubview:btn];
//        LxDBAnyVar(btn);
//    }];
}
@end
