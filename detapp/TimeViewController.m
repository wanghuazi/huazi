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
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    indexTextField = 0;
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
    
    UIView *timeLabelRow = [[UIView alloc] initWithFrame:CGRectMake(0, 80, APP_WIDTH, 90)];
    [self.view addSubview:timeLabelRow];
    
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake((APP_WIDTH-180)/4, 0, 60, 30)];
    hourLabel.text = @"时";
    hourLabel.textColor = [UIColor whiteColor];
    hourLabel.textAlignment = NSTextAlignmentCenter;
    [timeLabelRow addSubview:hourLabel];
    hourTextField = [[UITextField alloc] initWithFrame:CGRectMake((APP_WIDTH-180)/4, 30, 60, 60)];
    [timeLabelRow addSubview:hourTextField];
    hourTextField.delegate = self;
    if (!hourStr) {
        hourStr = @"00";
    }
    hourTextField.text = hourStr;
    hourTextField.tag = 201507061;
    hourTextField.placeholder = @"0-12";
    [hourTextField setTextAlignment:NSTextAlignmentCenter];
    hourTextField.backgroundColor = [UIColor whiteColor];
    [timeLabelRow addSubview:hourTextField];
    
    UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake((APP_WIDTH-180)/2+60, 0, 60, 30)];
    minLabel.text = @"分";
    minLabel.textColor = [UIColor whiteColor];
    minLabel.textAlignment = NSTextAlignmentCenter;
    [timeLabelRow addSubview:minLabel];
    minTextField = [[UITextField alloc] initWithFrame:CGRectMake((APP_WIDTH-180)/2+60, 30, 60, 60)];
    [timeLabelRow addSubview:minTextField];
    minTextField.delegate = self;
    minTextField.text = minute;
    minTextField.tag = 201507062;
    minTextField.placeholder = @"0-59";
    [minTextField setTextAlignment:NSTextAlignmentCenter];
    minTextField.backgroundColor = [UIColor whiteColor];
    [timeLabelRow addSubview:minTextField];
    
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake((APP_WIDTH-180)*3/4+120, 0, 60, 30)];
    secondLabel.text = @"秒";
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [timeLabelRow addSubview:secondLabel];
    secondTextField = [[UITextField alloc] initWithFrame:CGRectMake((APP_WIDTH-180)*3/4+120, 30, 60, 60)];
    [timeLabelRow addSubview:secondTextField];
    secondTextField.delegate = self;
    secondTextField.text = second;
    secondTextField.tag = 201507063;
    secondTextField.placeholder = @"0-59";
    [secondTextField setTextAlignment:NSTextAlignmentCenter];
    secondTextField.backgroundColor = [UIColor whiteColor];
    [timeLabelRow addSubview:secondTextField];
    
    UILabel *twoLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((APP_WIDTH-180)*3/8+60, 30, 5, 60)];
    twoLabel1.text = @":";
    twoLabel1.textAlignment=NSTextAlignmentCenter;
    twoLabel1.textColor = [UIColor whiteColor];
    [timeLabelRow addSubview:twoLabel1];
    
    UILabel *twoLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((APP_WIDTH-180)*5/8+120, 30, 5, 60)];
    twoLabel2.text = @":";
    twoLabel2.textAlignment=NSTextAlignmentCenter;
    twoLabel2.textColor = [UIColor whiteColor];
    [timeLabelRow addSubview:twoLabel2];
    
    UIButton *plusBtn = [[UIButton alloc] initWithFrame:CGRectMake((APP_WIDTH-250)/2, 200, 250, 40)];
    plusBtn.backgroundColor = [UIColor grayColor];
    [plusBtn setTitle:@"+" forState:UIControlStateNormal];
    plusBtn.tintColor = [UIColor whiteColor];
    [plusBtn addTarget:self action:@selector(plusTime) forControlEvents:UIControlEventTouchUpInside];
    [timeView addSubview:plusBtn];
    
    UIButton *reductionBtn = [[UIButton alloc] initWithFrame:CGRectMake((APP_WIDTH-250)/2, 270, 250, 40)];
    reductionBtn.backgroundColor = [UIColor grayColor];
    [reductionBtn setTitle:@"-" forState:UIControlStateNormal];
    reductionBtn.tintColor = [UIColor whiteColor];
    [reductionBtn addTarget:self action:@selector(reductionTime) forControlEvents:UIControlEventTouchUpInside];
    [timeView addSubview:reductionBtn];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake((APP_WIDTH-250)/2, 340, 250, 60)];
    closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn setTitle:@"确定" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeTimeView) forControlEvents:UIControlEventTouchUpInside];
    [timeView addSubview:closeBtn];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark textfielddelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    indexTextField = textField.tag;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 201507061) {
        if ([textField.text integerValue] >23) {
            textField.text = [NSString stringWithFormat:@"%d", 23];
        }
    } else {
        if ([textField.text integerValue] > 59) {
            textField.text = [NSString stringWithFormat:@"%d", 59];
        }
    }
}


#pragma mark - close function
- (void)plusTime
{
    UITextField *context = (UITextField*)[self.view viewWithTag:indexTextField];
    if (indexTextField == 201507061) {
        if ([context.text integerValue] < 24) {
            context.text = [NSString stringWithFormat:@"%d", [context.text integerValue]+1];
        }
    } else {
        if ([context.text integerValue] < 60) {
            context.text = [NSString stringWithFormat:@"%d", [context.text integerValue]+1];
        }
    }
    
}

- (void)reductionTime
{
    UITextField *context = (UITextField*)[self.view viewWithTag:indexTextField];
    if ([context.text integerValue] != 0 ) {
        context.text = [NSString stringWithFormat:@"%d", [context.text integerValue]-1];
    }
    
}

- (void)closeTimeView
{
    [self timer];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)timer
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *nowFormat = [NSDateFormatter new];
    nowFormat.dateFormat = @"YYYY-M-d";
    NSString *nowStr = [nowFormat stringFromDate:nowDate];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@ %@:%@:%@",nowStr ,hourTextField.text, minTextField.text, secondTextField.text];
    NSDateFormatter *future = [NSDateFormatter new];
    future.dateFormat = @"YYYY-M-d H:m:s";
    NSDate *futureDate = [future dateFromString:timeStr];
    NSTimeInterval futureInterval = [futureDate timeIntervalSinceNow];
    if (futureInterval <= 0) {
        
    } else  {
        if ([self.delegate respondsToSelector:@selector(timerSetSingle:)]) {
            [self.delegate timerSetSingle:futureDate];
        }
    }
    
    
}



@end
