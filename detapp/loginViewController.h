//
//  loginViewController.h
//  detapp
//
//  Created by wanghaohua on 15/5/6.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "socketController.h"
#import "ZBarSDK.h"

@interface loginViewController : UIViewController<REFrostedViewControllerDelegate, socketControllerDelegate, ZBarReaderDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, strong) UIImageView * line;
@property (strong, nonatomic) IBOutlet UIButton *localhostLogin;
@property (strong, nonatomic) IBOutlet UIButton *remoteLogin;
- (IBAction)localhostLogin:(id)sender;
- (IBAction)remoteLgoin:(UIButton *)sender;
- (IBAction)scanning:(id)sender;
- (IBAction)nameExit:(id)sender;
- (IBAction)pwdExit:(id)sender;
- (IBAction)textFiledReturnEditing:(id)sender;

@end
