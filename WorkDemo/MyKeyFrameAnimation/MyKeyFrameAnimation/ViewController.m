//
//  ViewController.m
//  MyKeyFrameAnimation
//
//  Created by 陈勇 on 15/9/13.
//  Copyright (c) 2015年 陈勇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIView *_redView;
    CGMutablePathRef _path;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];

}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    _path = CGPathCreateMutable();
    CGPathMoveToPoint(_path, NULL, point.x, point.y);
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    CGPathAddLineToPoint(_path, NULL, point.x, point.y);
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    CGPathMoveToPoint(_path, NULL, point.x, point.y);
    
    //关键帧动画
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframe.path = _path;
    keyframe.duration = 1;
    keyframe.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //基本动画
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.duration = 1;
    rotation.fromValue = @0;
    rotation.toValue = @(2*M_PI);
    
    //动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyframe, rotation];
    group.duration = 1;
    
    //代理
//    keyframe.delegate = self;
//    rotation.delegate = self;
    group.delegate = self;
    
//    [_redView.layer addAnimation:keyframe forKey:nil];
    [_redView.layer addAnimation:group forKey:nil];
    
    CGPathRelease(_path);
}

-(void) animationDidStart:(CAAnimation *)anim {
    NSLog(@"开始动画");
}
-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"结束动画");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





