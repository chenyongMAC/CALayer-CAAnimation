//
//  ViewController.m
//  MyCALayer
//
//  Created by 陈勇 on 15/9/13.
//  Copyright (c) 2015年 陈勇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CALayer *mylayer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mylayer = [CALayer layer];
    mylayer.backgroundColor = [UIColor redColor].CGColor;
    mylayer.bounds = CGRectMake(0, 0, 300, 300);
    mylayer.position = CGPointMake(200, 200);
//    mylayer.anchorPoint = CGPointMake(0.5, 1);
//    mylayer.contents = (id)[UIImage imageNamed:@"皮卡丘"].CGImage;
    
    //3D旋转的2种方式
    //1.属性方式
//    mylayer.transform = CATransform3DMakeScale(2, 1, 11);
    //2.KVO方式
//    [mylayer setValue:@-M_1_PI forKeyPath:@"transform.rotation.z"];
    
    [self.view.layer addSublayer:mylayer];
    
    mylayer.delegate = self;
    [mylayer setNeedsDisplay];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //begin和commit方法是默认的，如果不去除隐式动画可以不要添加
    [CATransaction begin];
    //去除隐式动画
//    [CATransaction setDisableActions:YES];
    //隐式动画
    mylayer.position = point;
    
    //提交动画
    [CATransaction commit];
}

-(void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 100, 100);
    CGPathAddLineToPoint(path, NULL, 200, 200);
    
    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);
    CGContextSetLineWidth(ctx, 10);
    
    CGContextAddPath(ctx, path);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGPathRelease(path);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
