//
//  ViewController.m
//  MyAnimation2
//
//  Created by 陈勇 on 15/9/13.
//  Copyright (c) 2015年 陈勇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImageView *_imageView;
    UIButton *_pauseBtn;
    UIButton *_resumeBtn;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imageView.image = [UIImage imageNamed:@"马里奥"];
    [self.view addSubview:_imageView];
    
    
    //1.添加动画
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basic.fromValue = @0;
    basic.toValue = @(2*M_PI);
    basic.duration = 2;
    basic.repeatCount = 10;
    [_imageView.layer addAnimation:basic forKey:@"rotationAnimation"];
    
    _pauseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _pauseBtn.frame = CGRectMake(100, 300, 50, 30);
    [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [_pauseBtn addTarget:self action:@selector(pauseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pauseBtn];
    
    _resumeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _resumeBtn.frame = CGRectMake(200, 300, 50, 30);
    [_resumeBtn setTitle:@"继续" forState:UIControlStateNormal];
    [_resumeBtn addTarget:self action:@selector(resumeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resumeBtn];
}

-(void) pauseBtnAction:(UIButton *)sender {
    //1.获取图层
    CALayer *layer = _imageView.layer;
    //2.获取图层暂停时候的“当前时间”
    CFTimeInterval pauseTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //3.速度为0，即停止动画
    layer.speed = 0;
    //4.记录图层相对于开始动画的时间偏移
    layer.timeOffset = pauseTime;
}

-(void) resumeBtnAction:(UIButton *) sender {
    //1.获取图层
    CALayer *layer = _imageView.layer;
    //2.速度为1，即开始正常速度的动画
    layer.speed = 1;
    
    //3.获取动画时间偏移
    CFTimeInterval pauseTime = layer.timeOffset;
    //4.清空时间数据(为了重新获取图层的时间偏移)
    layer.timeOffset = 0;
    layer.beginTime = 0;
    CFTimeInterval resumeTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    CFTimeInterval time = resumeTime - pauseTime;
    
    //5.通过时间偏移量，保证图层开始动画的时间和停止动画时候的时间相同(即图片动画效果连续)
    layer.beginTime = time;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
