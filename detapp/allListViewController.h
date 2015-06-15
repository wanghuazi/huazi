//
//  allListViewController.h
//  detapp
//
//  Created by wanghaohua on 15/5/12.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "socketController.h"
#import "singleViewController.h"

@interface allListViewController : UIViewController<socketControllerDelegate>
{
    UITabBarController *tabbarController;
}
@property (nonatomic, retain)UITabBarController *tabbarController;

@end
