//
//  ChartLineViewController.m
//  Charts
//
//  Created by Tangtang on 2016/10/31.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "ChartLineViewController.h"
#import "YXLBaseChart.h"
#import "YXLChartsFactory.h"

@interface ChartLineViewController ()

@end

@implementation ChartLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YXLBaseChart *lineChart = [YXLChartsFactory chartsFactory:YXLChartLine];
    lineChart.frame = CGRectMake(25, 110, [UIScreen mainScreen].bounds.size.width - 50, 280);
    lineChart.heightXDatas = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    lineChart.dataArray = @[@"11823", @"12345", @"3582", @"4987", @"16532", @"17982"];
    [lineChart drawChart];
    
    [self.view addSubview:lineChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
