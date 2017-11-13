//
//  ViewController.m
//  CircularArrowDemo
//
//  Created by Robert Ryan on 11/13/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

#import "ViewController.h"
#import "CircularArrowView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CircularArrowView *circularArrowView;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CFTimeInterval startTime;
@property (nonatomic) CGFloat animationBeginAngle;
@property (nonatomic) CGFloat animationFinalAngle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat angle = -M_PI_2;
    
    self.circularArrowView.startAngle = angle;
    self.circularArrowView.endAngle = angle;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}


- (void)startAnimation {
    self.duration = 2;
    self.animationBeginAngle = self.circularArrowView.endAngle;
    self.animationFinalAngle = self.circularArrowView.endAngle + M_PI * 3.0 / 2.0;

    self.startTime = CACurrentMediaTime();
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopAnimationForDisplayLink:(CADisplayLink *)displayLink {
    [displayLink invalidate];
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink; {
    CGFloat percent = MIN(1, (CACurrentMediaTime() - self.startTime) / self.duration);
    CGFloat angle = self.animationBeginAngle + percent * (self.animationFinalAngle - self.animationBeginAngle);
    self.circularArrowView.endAngle = angle;
    
    if (percent >= 1) {
        [self stopAnimationForDisplayLink:displayLink];
    }
}

@end
