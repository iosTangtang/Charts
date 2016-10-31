//
//  YXLPanCakeChart.m
//  Charts
//
//  Created by Tangtang on 2016/10/31.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "YXLPanCakeChart.h"

@interface YXLPanCakeChart ()

@property (nonatomic, strong) UIView            *gradientView;
@property (nonatomic, strong) CAGradientLayer   *gradientLayer;

@end

@implementation YXLPanCakeChart

- (UIView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,
                                                                 self.bounds.size.height)];
        [self addSubview:_gradientView];
    }
    return _gradientView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark Private Method
- (void)p_drawGrandientLayer {
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.gradientView.bounds;
    self.gradientLayer.startPoint = CGPointMake(0.f, 0.f);
    self.gradientLayer.endPoint = CGPointMake(1.f, 0.f);
    self.gradientLayer.colors = self.backgroundColors;
    [self.gradientView.layer addSublayer:self.gradientLayer];
}

- (void)p_drawPanCakeChart {
    //设置圆点
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    CGFloat endPoint, startPoint = -M_PI_2;
    CGFloat radius = self.bounds.size.height > self.bounds.size.width ? self.bounds.size.width / 3.0 : self.bounds.size.height / 3.0;
    
    __block CGFloat total = 0.f;
    [self.dataArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += [obj doubleValue];
    }];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:-M_PI_2 endAngle:M_PI * 3 / 2 clockwise:YES];
    
    for (int index = 0; index < self.dataArray.count; index++) {
        CGFloat value = [self.dataArray[0] doubleValue];
        endPoint = startPoint + (value / total);
    
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = self.panCakeColors[index].CGColor;
        shapeLayer.lineWidth = radius * 3.5 / 4.0;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.path        = bezierPath.CGPath;
        shapeLayer.strokeStart = startPoint + M_PI_2;
        shapeLayer.strokeEnd = endPoint + M_PI_2;
        
        [self.gradientView.layer addSublayer:shapeLayer];
        
        startPoint = endPoint;
        
        if (self.hasAnimation) {
            CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            basicAnimation.duration = self.animationDuration;
            basicAnimation.repeatCount = 1;
            basicAnimation.removedOnCompletion = YES;
            basicAnimation.fromValue = @0.0;
            basicAnimation.toValue = @1.0;
            [shapeLayer addAnimation:basicAnimation forKey:@"strokeEnd"];
        }
        
    }
    
}

#pragma mark Public Method
- (void)drawChart {
    [self p_drawGrandientLayer];
    
    [self p_drawPanCakeChart];
    
}


@end
