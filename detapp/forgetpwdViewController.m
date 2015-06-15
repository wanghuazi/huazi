//
//  forgetpwdViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/11.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "forgetpwdViewController.h"

@interface forgetpwdViewController ()

@end

@implementation forgetpwdViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_background"]]];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重设密码";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //修改navigattionbar
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    //修改leftBarButtonItem样式
    UIImageView *itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backward_btn_green"]];
    UITapGestureRecognizer *goBackTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goback)];
    itemImageView.userInteractionEnabled = YES;
    [itemImageView addGestureRecognizer:goBackTap];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:itemImageView];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)goback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
