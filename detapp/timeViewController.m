//
//  timeViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/29.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "timeViewController.h"
#import "Header.h"

@interface timeViewController ()

@end

@implementation timeViewController

-(void)loadView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    [view setBackgroundColor:[UIColor blackColor]];
    view.alpha = 0.5;
    self.view = view;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
