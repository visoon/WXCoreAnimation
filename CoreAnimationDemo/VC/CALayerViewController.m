//
//  CALayerViewController.m
//  CoreAnimationDemo
//
//  Created by vison on 16/8/18.
//  Copyright © 2016年 vison. All rights reserved.
//

#import "CALayerViewController.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

static float sideLength = 150;

@interface CALayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *imageView;

@property (nonatomic, strong)NSMutableArray<UIView *> *faces;

@property (nonatomic, assign)CATransform3D currentPerspective;
@end

@implementation CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1 / 500.0;
    perspective = CATransform3DRotate(perspective, - M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, - M_PI_4, 0, 1, 0);
    self.imageView.layer.sublayerTransform = perspective;

    CATransform3D transform0 = CATransform3DMakeTranslation(0, 0, sideLength / 2);
    
    CATransform3D transform1 = CATransform3DMakeTranslation(sideLength / 2, 0, 0);
    transform1 = CATransform3DRotate(transform1, M_PI_2, 0, 1, 0);
    
    CATransform3D transform2 = CATransform3DMakeTranslation(0, 0, - sideLength / 2);
    transform2 = CATransform3DRotate(transform2, M_PI, 0, 1, 0);
    
    CATransform3D transform3 = CATransform3DMakeTranslation(- sideLength / 2, 0, 0);
    transform3 = CATransform3DRotate(transform3, - M_PI_2, 0, 1, 0);
    
    CATransform3D transform4 = CATransform3DMakeTranslation(0, - sideLength / 2, 0);
    transform4 = CATransform3DRotate(transform4, M_PI_2, 1, 0, 0);
    
    CATransform3D transform5 = CATransform3DMakeTranslation(0, sideLength / 2, 0);
    transform5 = CATransform3DRotate(transform5, - M_PI_2, 1, 0, 0);
    
    [self addViewWithIndex:0 transform:transform0];
    [self addViewWithIndex:1 transform:transform1];
    [self addViewWithIndex:2 transform:transform2];
    [self addViewWithIndex:3 transform:transform3];
    [self addViewWithIndex:4 transform:transform4];
    [self addViewWithIndex:5 transform:transform5];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.currentPerspective = self.imageView.layer.sublayerTransform;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        float angleX = [sender locationInView:self.imageView].x / 200.0 * M_PI * 2;
        float angleY = [sender locationInView:self.imageView].y / 200.0 * M_PI * 2;
        self.currentPerspective = CATransform3DMakeRotation(angleX, 0, 1, 0);
        self.currentPerspective = CATransform3DRotate(self.currentPerspective, angleY, 1, 0, 0);
        self.imageView.layer.sublayerTransform = self.currentPerspective;
    }
}

- (void)addViewWithIndex:(NSInteger)index
               transform:(CATransform3D)transform {
    UIView *face = self.faces[index];
    face.frame = CGRectMake(0, 0, sideLength, sideLength);
    [self.imageView addSubview:face];
    face.layer.transform = transform;
}


- (NSMutableArray<UIView *> *)faces {
    if (_faces) {
        return _faces;
    }
    _faces = [NSMutableArray array];
    for (int i = 1; i < 7; i ++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
        view.bounds = CGRectMake(0, 0, sideLength, sideLength);
        
        UILabel *label = [UILabel new];
        label.bounds = CGRectMake(0, 0, 50, 50);
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(sideLength / 2, sideLength / 2);
        label.textColor = [UIColor colorWithRed:arc4random() / 255 / 255 green:arc4random() / 255 / 255 blue:arc4random() / 255 / 255 alpha:1];
        label.font = [UIFont boldSystemFontOfSize:30];
        label.text = [NSString stringWithFormat:@"%d", i];
        [view addSubview:label];
        [_faces addObject:view];
    }
    return _faces;
}
@end
