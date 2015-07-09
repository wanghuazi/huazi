//
//  testViewController.m
//  detapp
//
//  Created by wanghaohua on 15/6/22.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "groupViewController.h"
#import "Header.h"
#import "groupTableViewCell.h"
#import "socketController.h"
#import "CustomView.h"


@implementation groupViewController
@synthesize titles;
@synthesize doubleData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"组合编辑";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_bgtitle"]]];
    //修改navigattionbar
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    
    singleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, APP_WIDTH, APP_HEIGHT)];
    singleTableView.delegate = self;
    singleTableView.dataSource = self;
    [self.view addSubview:singleTableView];
    [singleTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_bgbobt"]]];
    
    SOCKETLAST.delegate = self;
    singleOpenIndex = 0;
    SOCKETLAST.singleArr = [[NSMutableArray alloc] init];
    singleTableView.tableHeaderView = [self tableHeader];
}

- (UIView*)tableHeader
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 135)];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 85)];
    [headerView addSubview:titleView];
    
    UIImageView *lightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 70)];
    lightImgView.image = [UIImage imageNamed:@"bangongshi"];
    [titleView addSubview:lightImgView];
    
    UITextField *groupName = [[UITextField alloc] initWithFrame:CGRectMake(95, 5, APP_WIDTH-115, 30)];
    groupName.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:groupName];
    
    UIButton *groupBtn = [[UIButton alloc] initWithFrame:CGRectMake(95, 45, 73, 30)];
    [groupBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [groupBtn setBackgroundImage:[UIImage imageNamed:@"delect_box@2x.png"] forState:UIControlStateNormal];
    [titleView addSubview:groupBtn];
    
    UILabel *tableHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, APP_WIDTH, 50)];
    tableHeader.text = @"电灯列表编辑";
    tableHeader.backgroundColor = [UIColor grayColor];
    [headerView addSubview:tableHeader];
    
    return headerView;
}

- (NSString *)stringFromHexString:(NSString *)hexString { //
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}

- (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

- (void)getSingleInfo
{
//    SOCKETLAST.singleArr = [NSMutableArray array];
    NSData *adata;
    if (SOCKETLAST.typeSocket == 1) {
        Byte byte[] = {0x0E, 0x00, 0x0c, 0x00,0x08, 0x00,0x08, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x81};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    } else {
        Byte byte[] = {0x08, 0x00, SOCKETLAST.sn4, SOCKETLAST.sn3, SOCKETLAST.sn2, SOCKETLAST.sn1, 0xFE, 0x81};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    }
    
    [SOCKETLAST writeData:adata];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.tabBarController.tabBar.hidden) {
        [self.tabBarController.tabBar setHidden:NO];
    }
    [self getSingleInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SOCKETLAST.singleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"singleCell";
    
    groupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[groupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([SOCKETLAST.singleArr firstObject]) {
        [cell createCell:[SOCKETLAST.singleArr objectAtIndex:indexPath.row]];
        NSArray *tmpArr = [[NSArray alloc] initWithObjects:@"0", [SOCKETLAST.singleArr objectAtIndex:indexPath.row], nil];
        [SOCKETLAST.groupArr addObject:tmpArr];
    }
    
    return cell;
}

#pragma mark - get single open status

- (void)getOpen:(NSData*)data
{
    Byte *openByte = (Byte *)[data bytes];
    Byte byte[] = {0x15,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x85,0x0C,0x02,openByte[2],openByte[3],0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    [SOCKETLAST writeData:adata];
}

#pragma mark socketControllerDelegate
-(void)readData:(NSData *)data remoteType:(NSString *)type
{
    Byte *singleByte = (Byte *)[data bytes];
    if (singleByte[0] == 0x01) {
        if (data.length > 38) {
            NSInteger dataLength = data.length / 38;
            for (NSInteger i=0; i < dataLength; i++) {
                [data getBytes:singleByte range:NSMakeRange(i*38, 38)];
                NSMutableArray *singleMutableArray = [NSMutableArray array];
                NSData *dataPart = [NSData dataWithBytes:singleByte length:38];
                [singleMutableArray addObject:dataPart];
                [SOCKETLAST.singleArr addObject:singleMutableArray];
                [self getOpen:dataPart];
            }
        } else {
            NSMutableArray *singleMutableArray = [NSMutableArray array];
            [singleMutableArray addObject:data];
            [SOCKETLAST.singleArr addObject:singleMutableArray];
            [self getOpen:data];
        }
        
    } else if (singleByte[0] == 0x07) {
        NSInteger indexOpen = 0;
        for (NSMutableArray *tmpArr in SOCKETLAST.singleArr) {
            NSData *tmpData = [tmpArr firstObject];
            Byte *tmpByte = (Byte *)[tmpData bytes];
            if (tmpByte[2]==singleByte[2] && tmpByte[3]==singleByte[3]) {
                [[SOCKETLAST.singleArr objectAtIndex:indexOpen] addObject:data];
            }
            indexOpen++;
            
        }
        singleOpenIndex++;
    }
    [singleTableView reloadData];
}

-(void)socketStatus:(BOOL)status
{
    NSLog(@"login socketStatus");
}


@end
