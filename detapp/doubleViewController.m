//
//  doubleViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/19.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "doubleViewController.h"
#import "Header.h"
#import "editDoubleViewController.h"
#import "doubleTableViewCell.h"
#import "socketController.h"
#import "CustomView.h"

@interface doubleViewController ()

@end

@implementation doubleViewController

@synthesize titles;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"组合控制";
    doubleIndex = 0;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_bgtitle"]]];
    //修改navigattionbar
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    //修改leftBarButtonItem样式
    UIImageView *itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_btn"]];
    UITapGestureRecognizer *goBackTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGroup)];
    itemImageView.userInteractionEnabled = YES;
    [itemImageView addGestureRecognizer:goBackTap];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:itemImageView];
    self.navigationItem.rightBarButtonItem = backButton;
    
    SOCKETLAST.doubleArr = [NSMutableArray array];
    NSData *adata;
    if (SOCKETLAST.typeSocket == 1) {
        Byte byte[] = {0x0E, 0x00, 0x0c, 0x00,0x08, 0x00,0x08, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x81};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    } else {
        Byte byte[] = {0x08, 0x00, SOCKETLAST.sn4, SOCKETLAST.sn3, SOCKETLAST.sn2, SOCKETLAST.sn1, 0xFE, 0x8E};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    }
    [SOCKETLAST writeData:adata];
    SOCKETLAST.delegate = self;
    
    doubleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, APP_WIDTH, APP_HEIGHT-40)];
    doubleTableView.delegate = self;
    doubleTableView.dataSource = self;
    [self.view addSubview:doubleTableView];
    [doubleTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_bgbobt"]]];
}


- (void)viewWillAppear:(BOOL)animated
{
    if (self.tabBarController.tabBar.hidden) {
        [self.tabBarController.tabBar setHidden:NO];
    }
//    if (!singleData) {
//        NSData *singleSend = [@"sdsd" dataUsingEncoding:NSUTF8StringEncoding];
//        if (SOCKETLAST) {
//            [SOCKETLAST writeData:singleSend];
//        }
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - my function
- (void)addGroup
{
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    editDoubleViewController *editDouble = [[editDoubleViewController alloc] init];
    [self.navigationController pushViewController:editDouble animated:YES];
    editDouble.doubleData = [SOCKETLAST.doubleArr objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SOCKETLAST.doubleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"doubleCell";
    
    doubleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[doubleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([SOCKETLAST.doubleArr firstObject]) {
        [cell createCell:[SOCKETLAST.doubleArr objectAtIndex:indexPath.row] andRow:indexPath.row];
    }
    return cell;
}

#pragma mark - get single open status


#pragma mark socketControllerDelegate
-(void)readData:(NSData *)data remoteType:(NSString *)type
{
    Byte *doubleByte = (Byte *)[data bytes];
    if (doubleByte[0] == 0x0c) {
        [SOCKETLAST.doubleArr addObject:data];
    }

    [doubleTableView reloadData];
}

-(void)socketStatus:(BOOL)status
{
    NSLog(@"login socketStatus");
}



@end
