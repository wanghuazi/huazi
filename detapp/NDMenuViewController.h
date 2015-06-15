//
//  NDMenuViewController.h
//  newnandu
//
//  Created by wanghaohua on 14-12-27.
//  Copyright (c) 2014年 newnandu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "allListViewController.h"

@interface NDMenuViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSIndexPath *lastDidselectIndexPath;
@property (strong, nonatomic) allListViewController *allListViewController;

@end
