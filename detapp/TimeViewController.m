//
//  TimeViewController.m
//  detapp
//
//  Created by wanghaohua on 15/6/16.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "TimeViewController.h"
#import "Header.h"

@interface TimeViewController ()

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    timeView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    timeView.backgroundColor = [UIColor blackColor];
    [timeView setAlpha:0.8];
    [self.view addSubview:timeView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, APP_WIDTH, 20)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"输入开始时间"];
    [timeView addSubview:titleLabel];
    
    UILabel *hourTextField = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 70, 70)];
    if (!hourStr) {
        hourStr = @"00";
    }
    [hourTextField setTextAlignment:NSTextAlignmentCenter];
    hourTextField.backgroundColor = [UIColor whiteColor];
    hourTextField.text = hourStr;
    [timeView addSubview:hourTextField];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 20, 80, 40)];
    closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn addTarget:self action:@selector(closeTimeView) forControlEvents:UIControlEventTouchUpInside];
    [timeView addSubview:closeBtn];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - close function
- (void)closeTimeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.navigationController.navigationBar.hidden = NO;
}



@end
