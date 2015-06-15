//
//  singleViewController.h
//  detapp
//
//  Created by wanghaohua on 15/5/18.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "socketController.h"

@interface singleViewController : UITableViewController<socketControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSData *singleData;
//    NSMutableArray *singleArr;
    NSInteger singleIndex;
}
@property (retain, nonatomic) NSArray *titles;
//@property (retain, nonatomic) NSMutableArray *singleArr;

@end
