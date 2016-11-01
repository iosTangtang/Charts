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
@property (nonatomic, copy)   NSMutableArray    *paths;
@property (nonatomic, strong) UILabel           *valueLabel;

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

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.textColor = [UIColor whiteColor];
        _valueLabel.font = self.valueLabelFont;
        [self addSubview:_valueLabel];
        
    }
    return _valueLabel;
}


- (NSMutableArray *)paths {
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
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
    if (self.dataArray.count <= 0) {
        return;
    }
    
    //设置圆点
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    CGFloat endPoint, startPoint = -M_PI_2;
    CGFloat radius = self.bounds.size.height > self.bounds.size.width ? self.bounds.size.width / 3.0 : self.bounds.size.height / 3.0;
    
    __block CGFloat total = 0.f;
    [self.dataArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += [obj doubleValue];
    }];
    
    
    for (int index = 0; index < self.dataArray.count; index++) {
        CGFloat value = [self.dataArray[index] doubleValue];
        endPoint = startPoint + (value / total) * M_PI * 2;
        
        // 绘制饼状图
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                                  radius:radius
                                                              startAngle:startPoint
                                                                endAngle:endPoint
                                                               clockwise:YES];
    
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = self.panCakeColors[index].CGColor;
        shapeLayer.lineWidth = radius * 3.5 / 4.0;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.path        = bezierPath.CGPath;
        shapeLayer.strokeStart = 0;
        shapeLayer.strokeEnd = 1;
        
        [self.gradientView.layer addSublayer:shapeLayer];
        
        // 绘制点击区域
        CGPoint minPoint = CGPointMake((bezierPath.currentPoint.x + centerPoint.x) / 2.0, (bezierPath.currentPoint.y + centerPoint.y) / 2.0);
        CGPoint maxPoint = CGPointMake(2 * bezierPath.currentPoint.x - minPoint.x, 2 * bezierPath.currentPoint.y - minPoint.y);
        UIBezierPath *drawPath = [UIBezierPath bezierPath];
        
        UIBezierPath *minPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                               radius:radius
                                                           startAngle:startPoint
                                                             endAngle:endPoint
                                                            clockwise:YES];
        [minPath addLineToPoint:minPoint];
        [minPath addArcWithCenter:centerPoint radius:radius / 2.0 startAngle:endPoint endAngle:startPoint clockwise:NO];
        [minPath closePath];
        [drawPath appendPath:minPath];
        
        UIBezierPath *maxPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                               radius:radius
                                                           startAngle:startPoint
                                                             endAngle:endPoint
                                                            clockwise:YES];
        [maxPath addLineToPoint:maxPoint];
        [maxPath addArcWithCenter:centerPoint radius:radius / 2.0 * 3 startAngle:endPoint endAngle:startPoint clockwise:NO];
        [maxPath closePath];
        [drawPath appendPath:maxPath];
    
        startPoint = endPoint;
        
        [self.paths addObject:drawPath];
        
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

    self.valueLabel.frame = CGRectMake(centerPoint.x - radius / 2.0, centerPoint.y - 20, radius, 40);
    [self setNeedsDisplay];
    
}

#pragma mark Public Method
- (void)drawChart {
    [self p_drawGrandientLayer];
    
    [self p_drawPanCakeChart];
    
}

#pragma mark Touch Method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.dataArray.count <= 0) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (int index = 0 ; index < self.dataArray.count; index++) {
        UIBezierPath *bezierPath = self.paths[index];
        
        if ([bezierPath containsPoint:touchPoint]) {
            NSString *value = self.dataArray[index];
            NSLog(@"%@", value);
            self.valueLabel.text = value;
            self.valueLabel.textColor = self.panCakeColors[index];
            break;
        }
        
    }
}

@end
