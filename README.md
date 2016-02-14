# YCMultimediaShowBtn
智能识别需要展示的多媒体文件按钮

* 通过传入一个字符串文件地址，来智能识别并展示按钮需要展示的内容
* 新增：demo按钮长按删除功能，删除后自动排列整理

#用法：
 1. 也可以关联相关xib或storyboard的类别
```objc
    // self.imageIcon为关联storyboard中的按钮
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    self.imageIcon.filePath = imagePath;
    // self.vedioBtn为关联storyboard中的按钮
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"testMOV" ofType:@"mov"];
    self.vedioBtn.filePath = videoPath;
    self.vedioBtn.showOnVC = self;
    // 同理
     NSString *voicePath = [[NSBundle mainBundle] pathForResource:@"Katy Perry - Roar" ofType:@"mp3"];
    self.voiceBtn.filePath = voicePath;
    self.vedioBtn.showOnVC = self;
```
 2. 可以使用代码的工厂方法进行创建
```
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
```
#效果图
***
![效果图](https://github.com/yangchao0033/YCMultimediaShowBtn/blob/master/YCMultimediaBtnTest/gif%E9%85%8D%E5%9B%BE%E5%A4%9A%E5%AA%92%E4%BD%93%E6%8C%89%E9%92%AE.gif)
