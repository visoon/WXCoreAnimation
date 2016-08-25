//
//  ClockViewController.m
//  CoreAnimationDemo
//
//  Created by vison on 16/8/18.
//  Copyright © 2016年 vison. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *hour;
@property (weak, nonatomic) IBOutlet UIImageView *min;
@property (weak, nonatomic) IBOutlet UIImageView *second;

@property (nonatomic, weak)NSTimer *timer;
@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hour.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.min.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.second.layer.anchorPoint = CGPointMake(0.5, 0.8);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self tick];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.timer fire];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
}

- (void)tick {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    
    self.hour.transform = CGAffineTransformMakeRotation(M_PI / 12.0 * components.hour * 2.0);
    self.min.transform = CGAffineTransformMakeRotation(M_PI / 60.0 * components.minute * 2.0);
    self.second.transform = CGAffineTransformMakeRotation(M_PI / 60.0 * components.second * 2.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
