//
//  testViewController.h
//  detapp
//
//  Created by wanghaohua on 15/6/22.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "socketController.h"

@interface singleViewController : UIViewController<socketControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSData *singleData;
    NSInteger singleOpenIndex;
    UITableView *singleTableView;
}
@property (retain, nonatomic) NSArray *titles;
@end
