//
//  PointModel.h
//  CoreAnimationDemo
//
//  Created by vison on 16/8/25.
//  Copyright © 2016年 vison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface PointModel : NSObject
- (instancetype)initWithPoint:(CGPoint)point
                        angle:(float)angle;
@property (nonatomic, assign, readonly)CGPoint point;
@property (nonatomic, assign, readonly)float angle;
@end
