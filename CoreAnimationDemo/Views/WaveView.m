//
//  WaveView.m
//  CoreAnimationDemo
//
//  Created by vison on 16/8/19.
//  Copyright © 2016年 vison. All rights reserved.
//

#import "WaveView.h"

static float during = 0.2f;

@interface WaveView ()
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
@property (nonatomic, strong)CAGradientLayer *colorBGLayer;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation WaveView

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    [self.timer fire];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenChange:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.timer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect {
    self.shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    
    self.colorBGLayer.frame = rect;
    [self.layer addSublayer:self.colorBGLayer];
    self.colorBGLayer.mask = self.shapeLayer;
}

#pragma mark - private methods

- (UIBezierPath *)randomPathWithRect:(CGRect)rect {
    float height = rect.size.height;
    float width = rect.size.width;
    NSInteger pointCount = 15;
    float pointSpace = width / (pointCount - 1) * 1.0f;
    
    
    NSMutableArray *points = [NSMutableArray array];
    CGPoint beginPoint = CGPointMake(0, height);
    CGPoint endPoint = CGPointMake(width, height);
    [points addObject:NSStringFromCGPoint(beginPoint)];
    for (int i = 1; i < pointCount - 1; i ++) {
        float pointX = pointSpace * i;
        float pointY = arc4random() % (int)height;
        [points addObject:NSStringFromCGPoint(CGPointMake(pointX, pointY))];
    }
    [points addObject:NSStringFromCGPoint(endPoint)];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:beginPoint];
    CGPoint lastPoint = beginPoint;
    for (NSString *pointString in points) {
        CGPoint point = CGPointFromString(pointString);
        [path addCurveToPoint:point controlPoint1:CGPointMake(lastPoint.x + pointSpace / 2.0, lastPoint.y) controlPoint2:CGPointMake(point.x - pointSpace / 2.0, point.y)];
        lastPoint = point;
    }
    return path;
}

#pragma mark - response methods
- (void)change {
    UIBezierPath *path = [self randomPathWithRect:self.bounds];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = during;
    animation.removedOnCompletion = NO;
    animation.fromValue = (__bridge id)self.shapeLayer.path;
    animation.toValue = (__bridge id)path.CGPath;
    self.shapeLayer.path = path.CGPath;
    [self.shapeLayer addAnimation:animation forKey:nil];
}

- (void)screenChange:(NSNotification *)notification {
    [self setNeedsDisplay];
}

#pragma mark - getter
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:during target:self selector:@selector(change) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (CAGradientLayer *)colorBGLayer {
    if (!_colorBGLayer) {
        _colorBGLayer = [CAGradientLayer layer];
        _colorBGLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
        _colorBGLayer.startPoint = CGPointMake(0.5, 1);
        _colorBGLayer.endPoint = CGPointMake(0.5, 0);
    }
    return _colorBGLayer;
}



@end
