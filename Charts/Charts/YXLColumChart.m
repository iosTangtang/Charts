//
//  YXLColumChart.m
//  Charts
//
//  Created by Tangtang on 2016/10/30.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "YXLColumChart.h"

static int const bounceX = 5;

@interface YXLColumChart () {
    CGFloat _maxLabelWidth;
}

@property (nonatomic, strong) UIView            *gradientView;
@property (nonatomic, strong) CAGradientLayer   *gradientLayer;
@property (nonatomic, assign) int               maxData;
@property (nonatomic, assign) int               total;

@end

@implementation YXLColumChart

- (UIView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[UIView alloc] initWithFrame:CGRectMake(confineX, 0, self.bounds.size.width - confineX,
                                                                 self.bounds.size.height - confineY)];
        [self addSubview:_gradientView];
    }
    return _gradientView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maxData = 0;
        _total = 0;
        _maxLabelWidth = 0;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark Private Method
- (void)p_createDataX {
    NSUInteger number = self.heightXDatas.count;
    for (int index = 0; index < number; index++) {
        UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - _maxLabelWidth) / number * index + _maxLabelWidth,
                                                                        self.bounds.size.height - confineY / 2.0,
                                                                        (self.bounds.size.width - _maxLabelWidth) / number, confineY / 2.0)];
        monthLabel.tag = 1000 + (index + 1);
        monthLabel.textAlignment = NSTextAlignmentCenter;
        monthLabel.font = self.labelFont;
        monthLabel.text = self.heightXDatas[index];
        [self addSubview:monthLabel];
    }
}

- (void)p_createDataY {
    self.maxData = [self p_getMaxData];
    int dis = self.maxData % standardData;
    int count = (dis == 0) ? self.maxData / standardData: self.maxData / standardData + 1;
    self.total = count * standardData;
    
    CGFloat viewHeight = self.bounds.size.height - confineY;
    
    for (int index = 0; index < count; index++) {
        UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        dataLabel.tag = 2000 + (index + 1);
        dataLabel.textAlignment = NSTextAlignmentCenter;
        dataLabel.font = self.labelFont;
        dataLabel.text = [NSString stringWithFormat:@"%dk", (standardData / 1000) * (count - index)];
        [self addSubview:dataLabel];
        
        NSString *message = dataLabel.text;
        
        CGSize containerSize = CGSizeMake(confineX, confineY / 2.0);
        CGRect messageRect = [message boundingRectWithSize:containerSize options:NSStringDrawingUsesLineFragmentOrigin |
                              NSStringDrawingUsesFontLeading |
                              NSStringDrawingTruncatesLastVisibleLine
                                                attributes:@{NSFontAttributeName : dataLabel.font}
                                                   context:NULL];
        dataLabel.frame = CGRectMake(0, viewHeight / count * index, messageRect.size.width, ceil(messageRect.size.height));
        if (_maxLabelWidth <= messageRect.size.width) {
            _maxLabelWidth = messageRect.size.width;
        }
    }
    
    //创建分割线
    for (int index = 0; index < count; index++) {
        
        if (self.hasDashLine) {
            UIBezierPath *dashPath = [UIBezierPath bezierPath];
            dashPath.lineWidth = 1.f;
            dashPath.lineJoinStyle = kCGLineJoinRound;
            [dashPath moveToPoint:CGPointMake(0, viewHeight / count * index)];
            [dashPath addLineToPoint:CGPointMake(self.bounds.size.width - _maxLabelWidth, viewHeight / count * index)];
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.strokeColor = self.dashLineColor.CGColor;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.lineWidth = 1.f;
            shapeLayer.path = dashPath.CGPath;
            [self.gradientView.layer addSublayer:shapeLayer];
        }
    }
    
    self.gradientView.frame = CGRectMake(_maxLabelWidth, self.gradientView.frame.origin.y,
                                         self.gradientView.frame.size.width + confineX - _maxLabelWidth, self.gradientView.frame.size.height);
    self.gradientLayer.frame = self.gradientView.bounds;
    [self setNeedsDisplay];
    
}

- (void)p_drawGrandientLayer {
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.gradientView.bounds;
    self.gradientLayer.startPoint = CGPointMake(0.f, 0.f);
    self.gradientLayer.endPoint = CGPointMake(1.f, 0.f);
    self.gradientLayer.colors = self.backgroundColors;
    [self.gradientView.layer addSublayer:self.gradientLayer];
}

- (int)p_getMaxData {
    int max = 0;
    
    for (NSString *obj in self.dataArray) {
        if ([obj intValue] > max) {
            max = [obj intValue];
        }
    }
    
    return max;
}

- (void)p_drawColumChart {
    
    for (int index = 0; index < self.dataArray.count; index++) {
        UILabel *label = [self viewWithTag:1000 + (index + 1)];
        CGFloat arc = [self.dataArray[index] intValue];
        CGFloat height = arc / self.total * (self.bounds.size.height - confineY);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(label.center.x - _maxLabelWidth, label.frame.origin.y)];
        [path addLineToPoint:CGPointMake(label.center.x - _maxLabelWidth, self.bounds.size.height - confineY - height)];
        
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = self.lineColor.CGColor;
        shapeLayer.fillColor = self.lineColor.CGColor;
        shapeLayer.lineWidth = label.frame.size.width - bounceX * 2;
        [self.gradientView.layer addSublayer:shapeLayer];
        
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
    [self p_createDataY];
    [self p_createDataX];
    
    [self p_drawColumChart];
}

@end
