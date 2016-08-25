//
//  CircleWaveView.m
//  CoreAnimationDemo
//
//  Created by vison on 16/8/25.
//  Copyright © 2016年 vison. All rights reserved.
//

#import "CircleWaveView.h"
#import "PointModel.h"

static NSInteger pathPointsCount = 100;

@interface CircleWaveView ()

@end

@implementation CircleWaveView

- (void)drawRect:(CGRect)rect {

    NSArray *points = [self pointsArrayWithRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < points.count; i ++) {
        if (i == 0) {
            [path moveToPoint:CGPointFromString(points[i])];
            continue;
        }
        [path addLineToPoint:CGPointFromString(points[i])];
    }
    [path addLineToPoint:CGPointFromString(points[0])];
    [path stroke];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor orangeColor].CGColor;
    layer.path = path.CGPath;

    [self.layer addSublayer:layer];
}

- (void)randomPathWithFrame:(float)frame {
    NSArray *points = [self pointsArrayWithRect:self.bounds];
    
}

/**
 *  points in circle
 *
 *  @param rect
 *
 *  @return
 */
- (NSArray<PointModel *> *)pointsArrayWithRect:(CGRect)rect {
    float selfWidth = rect.size.width;
    float selfHeight = rect.size.height;
    float radius = MIN(selfHeight, selfWidth) / 4.0;
    float circleOffsetTop = selfHeight / 2.0 - radius;
    float circleOffsetLeft = selfWidth / 2.0 - radius;
    CGPoint center = CGPointMake(selfWidth / 2.0, selfHeight / 2.0);
    CGPoint beginPoint = CGPointMake(selfWidth / 2.0, selfHeight / 2.0 - radius);
    
    NSMutableArray *points = [NSMutableArray array];
    float angle = M_PI * 2 / pathPointsCount;
    for (int i = 0; i < pathPointsCount; i ++) {
        if (i == 0) {
            PointModel *model = [[PointModel alloc] initWithPoint:beginPoint angle:0.0];
            [points addObject:model];
            continue;
        }
        float pointAngle = angle * i;
        float x = sinf(pointAngle) * radius + radius + circleOffsetLeft;
        float y = - cosf(pointAngle) * radius + radius + circleOffsetTop;
        CGPoint point = CGPointMake(x, y);
        
        PointModel *model = [[PointModel alloc] initWithPoint:point angle:pointAngle];
        [points addObject:model];
    }
    return points;
}

@end
