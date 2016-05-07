//
//  CATransitionViewController.m
//  ALLayer
//
//  Created by Bo on 16/5/6.
//  Copyright © 2016年 Bo. All rights reserved.
//

#import "CATransitionViewController.h"

@interface CATransitionViewController ()
{
    UIImageView *_imgView;
    int _imgIndex;
}

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 300)];
    [_imgView setImage:[UIImage imageNamed:@"photo0.jpg"]];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) / 2, CGRectGetMaxY(_imgView.frame) + 50, 100, 40)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Click Me" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_imgView];
    [self.view addSubview:btn];
}

- (void)btnClick {
    if (_imgIndex == 0) {
        _imgIndex = 1;
    } else {
        _imgIndex = 0;
    }
    
    [_imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"photo%i.jpg", _imgIndex]]];

    [self transitionAnimation];
}

- (void)transitionAnimation {
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f;
    animation.type = @"oglFlip";
    animation.subtype = kCATransitionFromBottom;
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [_imgView.layer addAnimation:animation forKey:@"animation"];
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor greenColor];
//    [self.navigationController pushViewController:vc animated:animation];
//    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
}

@end
