//
//  editDoubleViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/19.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "editDoubleViewController.h"
#import "Header.h"

@interface editDoubleViewController ()

@end

@implementation editDoubleViewController
@synthesize doubleData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"组合编辑";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_background"]]];
    
    [self.tabBarController.tabBar setHidden:YES];
    //修改navigattionbar
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    //修改leftBarButtonItem样式
    UIImageView *itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backward_btn"]];
    UITapGestureRecognizer *goBackTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goback)];
    itemImageView.userInteractionEnabled = YES;
    [itemImageView addGestureRecognizer:goBackTap];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:itemImageView];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, APP_WIDTH, 85)];
    [self.view addSubview:titleView];
    
    UIImageView *lightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 70)];
    lightImgView.image = [UIImage imageNamed:@"bangongshi"];
    [titleView addSubview:lightImgView];
    
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
