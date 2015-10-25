//
//  ViewController.m
//  MyBasicAnimation
//
//  Created by 陈勇 on 15/9/13.
//  Copyright (c) 2015年 陈勇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImageView *_imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imageView.image = [UIImage imageNamed:@"小毛驴"];
    [self.view addSubview:_imageView];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CABasicAnimation *basicLeft = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicLeft.fromValue = @0;
    basicLeft.toValue = @(M_PI);
    basicLeft.autoreverses = YES;
    basicLeft.duration = 2;
    basicLeft.repeatCount = 10;
    [_imageView.layer addAnimation:basicLeft forKey:@"basicRotionAnimationLeft"];
    
    [_imageView.layer addAnimation:basicLeft forKey:@"leftAnimation"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
