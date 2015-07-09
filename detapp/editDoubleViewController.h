//
//  editDoubleViewController.h
//  detapp
//
//  Created by wanghaohua on 15/5/19.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "socketController.h"

@interface editDoubleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,socketControllerDelegate>
{
    UITableView *listWithSingle;
    NSInteger singleOpenIndex;
    UITableView *singleTable;
}

@property (nonatomic, retain) NSData *doubleData;

@end
