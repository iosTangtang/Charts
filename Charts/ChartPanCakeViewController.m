//
//  ChartPanCakeViewController.m
//  Charts
//
//  Created by Tangtang on 2016/10/31.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "ChartPanCakeViewController.h"
#import "YXLBaseChart.h"
#import "YXLChartsFactory.h"

@interface ChartPanCakeViewController ()

@end

@implementation ChartPanCakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YXLBaseChart *panChart = [YXLChartsFactory chartsFactory:YXLChartPanCake];
    panChart.frame = CGRectMake(25, 110, [UIScreen mainScreen].bounds.size.width - 50, 280);
    panChart.heightXDatas = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    panChart.dataArray = @[@"11823", @"12345", @"3582", @"4987", @"16532", @"17982"];
    
    [panChart drawChart];
    
    [self.view addSubview:panChart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
