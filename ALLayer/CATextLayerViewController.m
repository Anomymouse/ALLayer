//
//  CATextLayerViewController.m
//  ALLayer
//
//  Created by Bo on 16/5/5.
//  Copyright © 2016年 Bo. All rights reserved.
//

#import "CATextLayerViewController.h"
#import <CoreText/CoreText.h>

@interface CATextLayerViewController ()
{
    UIView *_textView;
}

@end

@implementation CATextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) / 4, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) / 2)];
    _textView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_textView];
    
    [self setupTextLayer];
}

- (void)setupTextLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = _textView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [_textView.layer addSublayer:textLayer];
    
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    NSString *text = @"致力于搭建基于移动互联网的供应链交易和管理平台，专注商超零售行业，解决行业供应链不透明、门槛高、低效率、高成本、难管理的难题，让商超零售企业和供应商随时随地地互联互通，以最高效、平等、诚信的方式做生意。链商还将利用平台大量优质资源，构建基于大数据的各类云供应链服务，为客户创造价值，开启零售采购大电商时代。";
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    CFStringRef fontName = (__bridge  CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    NSDictionary *attribs = @{(__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor greenColor].CGColor,
                              (__bridge id)kCTFontAttributeName:(__bridge id)fontRef};

    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName:@(kCTUnderlineStyleDouble),
                (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    CFRelease(fontRef);
    
    textLayer.string = string;
}

@end
