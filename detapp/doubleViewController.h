//
//  doubleViewController.h
//  detapp
//
//  Created by wanghaohua on 15/5/19.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "socketController.h"

@interface doubleViewController : UIViewController<socketControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSData *singleData;
    NSInteger doubleIndex;
    UITableView *doubleTableView;
}
@property (retain, nonatomic) NSArray *titles;
@end
