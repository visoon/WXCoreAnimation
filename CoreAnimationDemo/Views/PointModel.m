//
//  PointModel.m
//  CoreAnimationDemo
//
//  Created by vison on 16/8/25.
//  Copyright © 2016年 vison. All rights reserved.
//

#import "PointModel.h"

@implementation PointModel
- (instancetype)initWithPoint:(CGPoint)point
                        angle:(float)angle
{
    self = [super init];
    if (self) {
        _point = point;
        _angle = angle;
    }
    return self;
}
@end
