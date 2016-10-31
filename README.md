# Charts

简单的图表绘制组件，功能不多，但是支持自定义。正在持续更新中...

###LineChart
![line](https://github.com/iosTangtang/Charts/blob/master/Charts/Resource/Simulator%20Screen%20Shot%202016年10月31日%20下午11.12.23.png)

###BarChart
![Bar](https://github.com/iosTangtang/Charts/blob/master/Charts/Resource/Simulator%20Screen%20Shot%202016年10月31日%20下午11.12.32.png)

###PanCakeChart
![PanCake](https://github.com/iosTangtang/Charts/blob/master/Charts/Resource/Simulator%20Screen%20Shot%202016年10月31日%20下午11.42.40.png)

###使用方法
```
YXLBaseChart *lineChart = [YXLChartsFactory chartsFactory:YXLChartLine];
 lineChart.frame = CGRectMake(25, 110, [UIScreen mainScreen].bounds.size.width - 50, 280);
 lineChart.heightXDatas = @[@"1", @"2", @"3", @"4", @"5", @"6"];
 lineChart.dataArray = @[@"11823", @"12345", @"3582", @"4987", @"16532", @"17982"];
 [lineChart drawChart];
    
 [self.view addSubview:lineChart];
```

###设置属性以达到自定义
```
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
```

###枚举类型
```
typedef enum : NSUInteger {
    YXLChartLine,                   // 折线图
    YXLChartColumnar,               // 柱状图
    YXLChartPanCake                 // 饼图
} YXLChartType;
```

