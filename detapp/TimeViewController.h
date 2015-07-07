//
//  TimeViewController.h
//  detapp
//
//  Created by wanghaohua on 15/6/16.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeViewControllerDelegate <NSObject>

- (void)timerSetSingle:(NSDate*)timeStr;

@end


@interface TimeViewController : UIViewController<UITextFieldDelegate>
{
    UIView *timeView;
    NSString *hourStr;
    NSString *minute;
    NSString *second;
    NSString *textFieldEdit;
    NSInteger indexTextField;
    
    UITextField *hourTextField;
    UITextField *minTextField;
    UITextField *secondTextField;
}

@property (nonatomic, strong) id<TimeViewControllerDelegate> delegate;

@end
