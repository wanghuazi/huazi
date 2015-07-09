//
//  editSingleViewController.h
//  detapp
//
//  Created by wanghaohua on 15/5/18.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "socketController.h"
#import "CustomView.h"
#import "CustomViewYuan.h"
#import "TimeViewController.h"

@interface editSingleViewController : UIViewController<socketControllerDelegate, TimeViewControllerDelegate>
{
    CustomViewYuan *showColorView;
    UIImage *colorImage;
    UIImage *brightImage;
    UISlider *colorSlider;
    UISlider *brightSlider;
    UISlider *saturationSlider;
    NSString *seconds;
    Byte *singleByte;
    NSInteger isLight;   //1代表灯亮，0代表灯关，2代表没值
    UIButton *openImg;
    NSData *singleInfo;
    NSData *openInfo;
    UIButton *hourTextfield;
    UIButton *minuteTextfield;
}
@property (nonatomic, retain) NSArray *singleData;

@end
