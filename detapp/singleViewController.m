//
//  testViewController.m
//  detapp
//
//  Created by wanghaohua on 15/6/22.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "singleViewController.h"
#import "Header.h"
#import "editSingleViewController.h"
#import "sigleTableViewCell.h"
#import "socketController.h"
#import "CustomView.h"


@implementation singleViewController
@synthesize titles;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"单灯控制";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_bgtitle"]]];
    //修改navigattionbar
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    
    singleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, APP_WIDTH, APP_HEIGHT-40)];
    singleTableView.delegate = self;
    singleTableView.dataSource = self;
    [self.view addSubview:singleTableView];
    [singleTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_bgbobt"]]];
    
    SOCKETLAST.delegate = self;
    singleOpenIndex = 0;
    SOCKETLAST.singleArr = [[NSMutableArray alloc] init];
    
    
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
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if ([[SOCKETLAST.singleArr objectAtIndex:indexPath.row] count] > 1) {
    editSingleViewController *editSingle = [[editSingleViewController alloc] init];
    [self.navigationController pushViewController:editSingle animated:YES];
    editSingle.singleData = [SOCKETLAST.singleArr objectAtIndex:indexPath.row];
    //    }
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
    
    sigleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[sigleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([SOCKETLAST.singleArr firstObject]) {
        [cell createCell:[SOCKETLAST.singleArr objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

#pragma mark - get single open status

- (void)getOpen:(NSData*)data
{
    Byte *openByte = (Byte *)[data bytes];
    Byte byte[] = {0x15,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x85,0x0C,0x02,openByte[2],openByte[3],0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    BOOL isOpen = [SOCKETLAST writeData:adata];
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
