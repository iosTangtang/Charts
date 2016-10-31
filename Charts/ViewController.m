//
//  ViewController.m
//  Charts
//
//  Created by Tangtang on 2016/10/30.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "ViewController.h"
#import "YXLBaseChart.h"
#import "YXLChartsFactory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YXLBaseChart *lineChart = [YXLChartsFactory chartsFactory:YXLChartLine];
    lineChart.frame = CGRectMake(25, 110, [UIScreen mainScreen].bounds.size.width - 50, 280);
    lineChart.heightXDatas = @[@"1", @"2", @"3", @"4", @"5", @"6",@"7", @"8", @"9", @"10", @"11", @"12"];
    lineChart.dataArray = @[@"11823", @"12345", @"3582", @"4987", @"16532", @"17982",@"1111", @"2345", @"9876", @"10870", @"11432", @"12555"];
    [lineChart drawChart];
    
    [self.view addSubview:lineChart];
    
    YXLBaseChart *columChart = [YXLChartsFactory chartsFactory:YXLChartColumnar];
    columChart.frame = CGRectMake(25, 420, [UIScreen mainScreen].bounds.size.width - 50, 280);
    columChart.heightXDatas = @[@"1", @"2", @"3", @"4", @"5", @"6",@"7", @"8", @"9", @"10", @"11", @"12"];
    columChart.dataArray = @[@"11823", @"12345", @"3582", @"4987", @"16532", @"17982",@"11111", @"2345", @"9876", @"10870", @"11432", @"12555"];
    [columChart drawChart];
    
    [self.view addSubview:columChart];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
