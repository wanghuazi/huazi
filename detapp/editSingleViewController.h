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

@interface editSingleViewController : UIViewController<socketControllerDelegate>
{
    CustomViewYuan *showColorView;
    UIImage *colorImage;
    UIImage *brightImage;
    UISlider *colorSlider;
    UISlider *brightSlider;
    UISlider *saturationSlider;
    NSString *hourStr;
    NSString *minute;
    NSString *seconds;
    Byte *singleByte;
}
@property (nonatomic, retain) NSData *singleData;

@end
