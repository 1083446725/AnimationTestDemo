//
//  ViewController.m
//  AnimationTestDemo
//
//  Created by guodongdong on 2019/9/4.
//  Copyright © 2019 guodongdong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) CAAnimationGroup *groupDisapperAnimation;
@property (nonatomic, strong) CAAnimationGroup *groupAppearAnimation;
@property (nonatomic, strong) CAAnimationGroup *groupRepeatAnimation;


@property (nonatomic, strong) UIImageView *iv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *iv = [UIImageView new];
    iv.image = [UIImage imageNamed:@"follow_postdetail"];
    [self.view addSubview:iv];
    iv.frame = CGRectMake(100, 200, 200, 200);
    self.iv = iv;
    
    // 通过代理实现心跳
    [self.iv.layer addAnimation:self.groupDisapperAnimation forKey:@"groupDisappearAnimation"];
 
    // 循环类似心跳
//    [self test];
}

// 循环类似心跳
- (void)test {
    [self.iv.layer addAnimation:self.groupRepeatAnimation forKey:@"groupRepeatAnimation"];
}

#pragma -mark animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if ([self.iv.layer animationForKey:@"groupDisappearAnimation"] == anim) {

        [self.iv.layer addAnimation:self.groupAppearAnimation forKey:@"groupAppearAnimation"];
    }
    
    if ([self.iv.layer animationForKey:@"groupAppearAnimation"] == anim) {
        [self.iv.layer addAnimation:self.groupDisapperAnimation forKey:@"groupDisappearAnimation"];
    }
}

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (CAAnimationGroup *)groupDisapperAnimation {
    if (!_groupDisapperAnimation) {
        CAKeyframeAnimation *scale1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale1.values = @[@1.0, @0.5];
        scale1.beginTime = 0.0;
        scale1.duration= 3;
        CAKeyframeAnimation *opacity1 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacity1.values = @[@1.0, @0.0];
        opacity1.beginTime = 0.0;
        opacity1.duration = 3;
        
        _groupDisapperAnimation = [CAAnimationGroup animation];
        _groupDisapperAnimation.animations = @[scale1, opacity1];
        _groupDisapperAnimation.duration = 3;
        _groupDisapperAnimation.removedOnCompletion = NO;
        _groupDisapperAnimation.fillMode = kCAFillModeForwards;
        _groupDisapperAnimation.repeatCount = 1;
        _groupDisapperAnimation.delegate = self;
    }
    return _groupDisapperAnimation;
}

- (CAAnimationGroup *)groupAppearAnimation {
    if (!_groupAppearAnimation) {
        CAKeyframeAnimation *scale2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale2.values = @[@0.5, @1];
        scale2.beginTime = 0.0;
        scale2.duration= 3;
        CAKeyframeAnimation *opacity2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacity2.values = @[@0.2, @0.7];
        opacity2.beginTime = 0.0;
        opacity2.duration = 3;
        
        _groupAppearAnimation = [CAAnimationGroup animation];
        _groupAppearAnimation.animations = @[scale2, opacity2];
        _groupAppearAnimation.duration = 3;
        _groupAppearAnimation.removedOnCompletion = NO;
        _groupAppearAnimation.fillMode = kCAFillModeForwards;
        _groupAppearAnimation.repeatCount = 1;
        _groupAppearAnimation.delegate = self;
    }
    return _groupAppearAnimation;
}

- (CAAnimationGroup *)groupRepeatAnimation {
    if (!_groupRepeatAnimation) {
        CAKeyframeAnimation *scale2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale2.values = @[@1, @.5, @1];
        scale2.beginTime = 0.0;
        scale2.duration= 3;
        CAKeyframeAnimation *opacity2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacity2.values = @[@1, @0, @1];
        opacity2.beginTime = 0.0;
        opacity2.duration = 3;
        
        _groupRepeatAnimation = [CAAnimationGroup animation];
        _groupRepeatAnimation.animations = @[scale2, opacity2];
        _groupRepeatAnimation.duration = 3;
        _groupRepeatAnimation.removedOnCompletion = NO;
        _groupRepeatAnimation.fillMode = kCAFillModeForwards;
        _groupRepeatAnimation.repeatCount = CGFLOAT_MAX;
        _groupRepeatAnimation.delegate = self;
    }
    return _groupRepeatAnimation;
}

@end
