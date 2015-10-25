//
//  ViewController.m
//  MyTransition
//
//  Created by 陈勇 on 15/9/14.
//  Copyright (c) 2015年 陈勇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImageView *_imageView;
    NSMutableArray *_imageArray;
    NSInteger index;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    
    _imageArray = [NSMutableArray array];
    for (NSInteger i=1; i<10; i++) {
        NSString *img = [NSString stringWithFormat:@"%li.jpg", i];
     [_imageArray addObject:img];
    }
    
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:swipe];
}
-(void) swipeAction:(UISwipeGestureRecognizer *)swipe {
    index ++;
//    NSLog(@"%d", index);
    if (index >= 9) {
        index = 0;
    }
    _imageView.image = [UIImage imageNamed:_imageArray[index]];
    
    
    //过场动画
    CATransition *transition = [[CATransition alloc] init];
    
//    transition.type = @"suckEffect";
    transition.type = kCATransitionPush;
    
//    transition.subtype = kCATransitionFromRight;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 0.5;
    [_imageView.layer addAnimation:transition forKey:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
