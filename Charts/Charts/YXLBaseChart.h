//
//  YXLBaseChart.h
//  Charts
//
//  Created by Tangtang on 2016/10/30.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const confineX = 40;
static CGFloat const confineY = 20;
static int const standardData = 5000;

@interface YXLBaseChart : UIView

@property (nonatomic, strong)   UIColor                 *lineColor;                         // 线条颜色
@property (nonatomic, strong)   UIColor                 *dashLineColor;                     // 虚线颜色
@property (nonatomic, assign)   CGFloat                 lineWidth;                          // 线条宽度
@property (nonatomic, strong)   UIFont                  *labelFont;                         // label字体
@property (nonatomic, assign)   BOOL                    hasDashLine;                        // 是否开启坐标虚线
@property (nonatomic, assign)   BOOL                    hasAnimation;                       // 是否开启动画
@property (nonatomic, assign)   CGFloat                 animationDuration;                  // 动画时间
@property (nonatomic, copy)     NSArray <NSString *>    *dataArray;                         // 需要制作成图表的数据
@property (nonatomic, copy)     NSArray <NSString *>    *heightXDatas;                      // X坐标数据
@property (nonatomic, copy)     NSArray <UIColor *>     *backgroundColors;                  // 图标背景渐变颜色组
@property (nonatomic, copy)     NSArray <UIColor *>     *panCakeColors;                     // 饼图中的颜色组

- (void)drawChart;

@end
