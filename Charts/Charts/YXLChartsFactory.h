//
//  YXLChartsFactory.h
//  Charts
//
//  Created by Tangtang on 2016/10/30.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXLBaseChart.h"

typedef enum : NSUInteger {
    YXLChartLine,
    YXLChartColumnar,
    YXLChartPanCake,
} YXLChartType;

@interface YXLChartsFactory : NSObject

+ (YXLBaseChart *)chartsFactory:(YXLChartType)chartType;

@end
