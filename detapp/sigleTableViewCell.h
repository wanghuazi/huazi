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


@interface sigleTableViewCell : UITableViewCell<socketControllerDelegate>
{
    
}
@property (nonatomic, retain) NSData *cellData;
- (void) createCell:(NSData*)data;

@end
