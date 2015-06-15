//
//  NDNavigationController.m
//  newnandu
//
//  Created by wanghaohua on 14-12-27.
//  Copyright (c) 2014年 newnandu. All rights reserved.
//

#import "NDNavigationController.h"
#import "NDMenuViewController.h"
#include "UIViewController+REFrostedViewController.h"

@interface NDNavigationController ()

@property (strong, readwrite, nonatomic) NDNavigationController *menuViewController;

@end

@implementation NDNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBar.backgroundColor= [UIColor colorWithRed:57.0/255.0 green:158.0/255 blue:209.0/255 alpha:1.0];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
}


- (void)showMenu
{
    // Dismiss keyboard (optional)
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];

    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

@end


