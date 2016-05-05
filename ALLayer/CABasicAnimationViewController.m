//
//  CABasicAnimationViewController.m
//  ALLayer
//
//  Created by Bo on 16/5/4.
//  Copyright © 2016年 Bo. All rights reserved.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()
{
    CALayer *_layer;
}

@end

@implementation CABasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _layer = [[CALayer alloc] init];
    _layer.backgroundColor = [UIColor yellowColor].CGColor;
    _layer.frame = CGRectMake((self.view.bounds.size.width - 200) / 2, 50, 200, 200);
    //给layer加上图片，1. 使用drwaLayer:InContex 2. 使用layer.contents
    _layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"photo.jpg"].CGImage);
    [self.view.layer addSublayer:_layer];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testAnimation) forControlEvents:UIControlEventTouchUpInside];
}

- (void)testAnimation {
    //缩放
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = @(1);
    animation1.toValue = @(1.5);
    animation1.autoreverses = YES;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.duration = 0.8;

    //平移
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation2.fromValue = [NSValue valueWithCGPoint:_layer.position];
    animation2.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    animation2.autoreverses = YES;
    animation2.removedOnCompletion = NO;
    animation2.duration = 0.8;
    
    //旋转
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation3.fromValue = @(0);
    animation3.toValue = @(M_PI);
    animation3.autoreverses = YES;
    animation3.removedOnCompletion = NO;
    animation3.duration = 0.8;
    
    //组合动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 0.8;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.autoreverses = YES;
    groupAnimation.repeatCount = MAXFLOAT;
    groupAnimation.animations = @[animation1, animation2, animation3];
    
    [_layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

@end
