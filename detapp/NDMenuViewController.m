//
//  NDMenuViewController.m
//  newnandu
//
//  Created by wanghaohua on 14-12-27.
//  Copyright (c) 2014年 newnandu. All rights reserved.
//

#import "NDMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "Header.h"

@implementation NDMenuViewController
@synthesize lastDidselectIndexPath;
@synthesize allListViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //表单分割线颜色
//    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor blackColor];
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    allListViewController *listViewController = [[allListViewController alloc] init];
    
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:listViewController];
        self.frostedViewController.contentViewController = navigationController;
    
//    }
    
    [self.frostedViewController hideMenuViewController];
    UITableViewCell *lastDidselectCell = tableView.visibleCells[self.lastDidselectIndexPath.row];
    UITableViewCell *indexPathCell = tableView.visibleCells[indexPath.row];
    [lastDidselectCell.textLabel setTextColor:[UIColor colorWithRed:62/255.0f
                                                              green:68/255.0f
                                                               blue:75/255.0f
                                                              alpha:1.0f]];
    [indexPathCell.textLabel setTextColor:[UIColor whiteColor]];
    self.lastDidselectIndexPath = indexPath;
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Celltest";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Home", @"Profile", @"Chats", @"Chats"];
        cell.textLabel.text = titles[indexPath.row];
    } else {
        NSArray *titles = @[@"John Appleseed", @"John Doe", @"Test User", @"Chats"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}




@end
