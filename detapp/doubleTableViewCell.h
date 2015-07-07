//
//  doubleTableViewCell.h
//  detapp
//
//  Created by wanghaohua on 15/6/21.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "socketController.h"


@interface doubleTableViewCell : UITableViewCell
{
    NSInteger isLight;   //1代表灯亮，0代表灯关，2代表没值
    NSData *doubleWithData;
    
}
@property (nonatomic, retain) NSData *cellData;
- (void) createCell:(NSData*)data andRow:(NSInteger)index;

@end
