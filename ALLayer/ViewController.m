//
//  ViewController.m
//  ALLayer
//
//  Created by Bo on 16/5/3.
//  Copyright © 2016年 Bo. All rights reserved.
//

#import "ViewController.h"

#define kWidth 100

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self drawALLayer];
//    [self drawALLayer1];
    [self drawALLayer2];
    
    [self drawALLayer3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 绘制图层
- (void)drawALLayer {
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //这是设置中心点
    layer.position = CGPointMake(50, 50);
    layer.bounds = CGRectMake(0, 0, kWidth, kWidth);
    layer.cornerRadius = kWidth / 2;
    //设置阴影属性
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = .9;
    
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=1;

//    设置锚点
//  所谓的锚点就是指图形的四个角和中点(也可以是图形其他位置)，哪个跟中心点position重合，比如（0.5， 0.5）是图形的中心点跟position重合，（1，1）是右下角跟position重合，而position的位置这个时候是不变的
    layer.anchorPoint=CGPointMake(0.5, 0.5);
    
    [self.view.layer addSublayer:layer];
}

#pragma mark 绘制图层，阴影被裁剪掉了
- (void)drawALLayer1 {
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    //这是设置中心点
    layer.position = CGPointMake(50, 150);
    layer.bounds = CGRectMake(0, 0, kWidth, kWidth);
    layer.cornerRadius = kWidth / 2;
    //设置阴影属性
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = .9;
    
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=1;
    
    //需要注意的是上面代码中绘制图片圆形裁切效果时如果不设置masksToBounds是无法显示圆形，但是对于其他图形却没有这个限制。原因就是当绘制一张图片到图层上的时候会重新创建一个图层添加到当前图层，这样一来如果设置了圆角之后虽然底图层有圆角效果，但是子图层还是矩形，只有设置了masksToBounds为YES让子图层按底图层剪切才能显示圆角效果。同样的，有些朋友经常在网上提问说为什么使用UIImageView的layer设置圆角后图片无法显示圆角，只有设置masksToBounds才能出现效果，也是类似的问题, 在这里可以把下面代码注释看看裁剪效果
    layer.masksToBounds = YES;
    
    //    设置锚点
    //  所谓的锚点就是指图形的四个角和中点(也可以是图形其他位置)，哪个跟中心点position重合，比如（0.5， 0.5）是图形的中心点跟position重合，（1，1）是右下角跟position重合，而position的位置这个时候是不变的
    //    layer.anchorPoint=CGPointMake(0.5, 0.5);
    
    layer.delegate = self;
    [self.view.layer addSublayer:layer];
    
    [layer setNeedsDisplay];
}

//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    CGContextSaveGState(ctx);
//    //图形上下文进行了翻转
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -100);
//    //逐行了解代码的作用
//    UIImage *image = [UIImage imageNamed:@"photo.jpg"];
//    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), image.CGImage);
//    CGContextRestoreGState(ctx);
//}

#pragma mark 绘制图层，阴影不被裁剪掉，用两个图层解决
- (void)drawALLayer2 {
    CGPoint position= CGPointMake(160, 200);
    CGRect bounds=CGRectMake(0, 0, 100, 100);
    CGFloat cornerRadius=100/2;
    CGFloat borderWidth=2;
    
    //阴影图层
    CALayer *layerShadow=[[CALayer alloc]init];
    layerShadow.bounds=bounds;
    layerShadow.position=position;
    layerShadow.cornerRadius=cornerRadius;
    layerShadow.shadowColor=[UIColor grayColor].CGColor;
    layerShadow.shadowOffset=CGSizeMake(2, 1);
    layerShadow.shadowOpacity=1;
    layerShadow.borderColor=[UIColor redColor].CGColor;
    layerShadow.borderWidth=borderWidth;
    [self.view.layer addSublayer:layerShadow];
    
    //容器图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=bounds;
    layer.position=position;
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=cornerRadius;
    layer.masksToBounds=YES;
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=borderWidth;
    
    //设置图层代理
    layer.delegate=self;
    
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

//绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -100);
    
    UIImage *image=[UIImage imageNamed:@"photo.jpg"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), image.CGImage);
    
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGContextRestoreGState(ctx);
}

//事实上如果仅仅就显示一张图片在图层中当然没有必要那么麻烦，直接设置图层contents就可以了，不牵涉到绘图也就没有倒立的问题了。
- (void)drawALLayer3 {
    CGPoint position= CGPointMake(160, 300);
    CGRect bounds=CGRectMake(0, 0, 100, 100);
    CGFloat cornerRadius=100/2;
    CGFloat borderWidth=2;
    
    //阴影图层
    CALayer *layerShadow=[[CALayer alloc]init];
    layerShadow.bounds=bounds;
    layerShadow.position=position;
    layerShadow.cornerRadius=cornerRadius;
    layerShadow.shadowColor=[UIColor grayColor].CGColor;
    layerShadow.shadowOffset=CGSizeMake(2, 1);
    layerShadow.shadowOpacity=1;
    layerShadow.borderColor=[UIColor redColor].CGColor;
    layerShadow.borderWidth=borderWidth;
    [self.view.layer addSublayer:layerShadow];
    
    //容器图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=bounds;
    layer.position=position;
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=cornerRadius;
    layer.masksToBounds=YES;
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=borderWidth;

    
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    
    //设置内容（注意这里一定要转换为CGImage）
    UIImage *image=[UIImage imageNamed:@"photo.jpg"];
    //    layer.contents=(id)image.CGImage;
    [layer setContents:(id)image.CGImage];}

@end
