//
//  AgroupView.m
//  Animation3Dmove
//
//  Created by myios on 2017/12/22.
//  Copyright © 2017年 郑惠珠. All rights reserved.
//

#import "AgroupView.h"

@interface AgroupView ()
{
    UIView *oneView;
    UIView *twoView;
    UIView *threeView;
    int subViewCount;
    CGPoint _startPoint;
    CGPoint _endPoint;
    CGFloat _size;
    NSArray *_avatarArray;
    
    NSTimer *timer;
}
@end

@implementation AgroupView
/**
 */
- (id)initWithFrame:(CGRect)frame withBlockSize:(CGFloat)size withImageArr:(NSArray *)avatarArr  withStartPoint:(CGPoint)startPoint withEndPoint:(CGPoint)endPoint {
    
    if (self = [super initWithFrame:frame]) {
        _size = size;
        _animationTime = 0.2f;
        _endPoint = endPoint;
        _startPoint = startPoint;
        _avatarArray = avatarArr;
        [self drawView];
    }
    return self;
}

- (void)drawView {
    
    for (int i = 0; i < 6; i++) {
        
        CGFloat a = self.frame.size.height;
        UIImageView *subView = [[UIImageView alloc] initWithFrame:CGRectMake(a - 10 * i, a - 10 * i, _size, _size)];

        subView.image = [UIImage imageNamed:_avatarArray[i]];
        subView.alpha = 0.0;
        [self addSubview:subView];
//        ViewRadius(subView, 5);
        switch (i) {
            case 0:
                oneView = subView;
                break;
            case 1:
                twoView = subView;
                break;
            case 2:
                threeView = subView;
                break;
            default:
                break;
        }
    }
    NSLog(@"%lu", (unsigned long)self.subviews.count);
    subViewCount = (int)self.subviews.count;
}

- (void)startAnimation {
    
    timer =  [NSTimer scheduledTimerWithTimeInterval:_animationTime/subViewCount  target:self selector:@selector(timeChange) userInfo:nil repeats:YES];

}


- (void)timeChange {
    
    subViewCount--;
    if (subViewCount < 0) {
        [timer invalidate];
        timer = nil;
        return;
    }
    UIView *view = self.subviews[subViewCount];
    [self beginAnimationWithLayer:view.layer withMoveToPoint:_endPoint];
   
}


- (UIColor *)randomColor {
    
    CGFloat red = arc4random()%255 / 255.0;
    CGFloat green = arc4random()%255 / 255.0;
    CGFloat blue = arc4random()%255 / 255.0;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}

- (void) beginAnimationWithLayer:(CALayer *)layer withMoveToPoint:(CGPoint)point {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_startPoint];
    
//    [path addLineToPoint:CGPointMake(point.x*0.1, point.y * 0.1)];
//    [path moveToPoint:CGPointMake(point.x*0.1, point.y * 0.1)];
    [path addLineToPoint:point];
    [path moveToPoint:point];
    
    path.lineWidth = 1;
    // 设置连接类型
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
    
    CAKeyframeAnimation *ani_move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置动画的路径为直线路径
    ani_move.path = path.CGPath;
//    ani_move.calculationMode = kCAAnimationCubic;
//    ani_move.keyTimes = @[@0.0, @0.1, @0.6, @0.7, @1.0];
//    ani_move.removedOnCompletion = NO;
    
    
    CABasicAnimation *ani_scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani_scale.fromValue = @(0.8);
    ani_scale.toValue = @(3.0);
    
    
    CABasicAnimation *ani_alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    ani_alpha.fromValue = @(0.8);
    ani_alpha.toValue = @(1.0);
    
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    CAMediaTimingFunction *timeFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationGroup.timingFunction = timeFunction;
    // 动画时间间隔
    animationGroup.duration = _animationTime;
    // 加速度
//    animationGroup.speed = 2.0;
//    animationGroup.timeOffset = animtionTime*2 / 3;
    
    // 重复次数为最大值
    animationGroup.repeatCount = FLT_MAX;
    
    animationGroup.animations = @[ani_move, ani_scale, ani_alpha];
//    animationGroup.fillMode = kCAFillModeBackwards;
    
    [layer addAnimation:animationGroup forKey:nil];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
