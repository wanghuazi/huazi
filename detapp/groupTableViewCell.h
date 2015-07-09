//
//  sigleCellTableViewCell.h
//  detapp
//
//  Created by wanghaohua on 15/5/20.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "socketController.h"


@interface groupTableViewCell : UITableViewCell<socketControllerDelegate>
{
    NSInteger isLight;   //1代表灯亮，0代表灯关，2代表没值
    NSMutableArray *openWithArr;
}
@property (nonatomic, retain) NSData *cellData;
- (void) createCell:(NSMutableArray*)arrWithData;

@end
