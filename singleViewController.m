//
//  singleViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/18.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "singleViewController.h"
#import "Header.h"
#import "editSingleViewController.h"
#import "sigleTableViewCell.h"
#import "socketController.h"
#import "CustomView.h"

@interface singleViewController ()

@end

@implementation singleViewController
@synthesize titles;

- (void)viewDidLoad {
//    singleArr = [[NSMutableArray alloc] init];
    NSData *adata;
    if (SOCKETLAST.typeSocket == 1) {
        Byte byte[] = {0x0E, 0x00, 0x0c, 0x00,0x08, 0x00,0x08, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x81};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    } else {
        Byte byte[] = {0x08, 0x00, SOCKETLAST.sn4, SOCKETLAST.sn3, SOCKETLAST.sn2, SOCKETLAST.sn1, 0xFE, 0x81};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    }
    
    BOOL abcd = [SOCKETLAST writeData:adata];
    SOCKETLAST.delegate = self;
    NSLog(@"SOCKETLAST %d and %@", abcd, adata);
    
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    Byte testByte[] = {0xb2, 0xe2,0xca,0xd4,0x33};
//    NSData *asdata = [[NSData alloc] initWithBytes:testByte length:sizeof(testByte)];
//    NSString *test = [[NSString alloc] initWithData:asdata encoding:enc];
//    NSLog(@"NSStringEncoding %@", test);
    
    
    self.titles = @[@"sorry, no data"];
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"单灯控制";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.

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
    NSLog(@"------字符串=======%@",unicodeString);
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



- (void)viewWillAppear:(BOOL)animated
{
    if (self.tabBarController.tabBar.hidden) {
        [self.tabBarController.tabBar setHidden:NO];
    }
    if (!singleData) {
        NSData *singleSend = [@"sdsd" dataUsingEncoding:NSUTF8StringEncoding];
        if (SOCKETLAST) {
            [SOCKETLAST writeData:singleSend];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (IBAction)testButton:(id)sender {
//    NSString *aString = @"bbbsss";
//    NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
//    [SOCKETLAST writeData:aData];
//}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    editSingleViewController *editSingle = [[editSingleViewController alloc] init];
    [self.navigationController pushViewController:editSingle animated:YES];
    editSingle.singleData = [SOCKETLAST.singleArr objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection %lu", (unsigned long)[SOCKETLAST.singleArr count]);
    return [SOCKETLAST.singleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"sigleCell";
    
    sigleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[sigleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([SOCKETLAST.singleArr firstObject]) {
        NSLog(@"firstObjectsss %@ and %@", [SOCKETLAST.singleArr firstObject], [SOCKETLAST.singleArr objectAtIndex:indexPath.row]);
//        cell.cellData = [SOCKETLAST.singleArr objectAtIndex:indexPath.row];
        [cell createCell:[SOCKETLAST.singleArr objectAtIndex:indexPath.row]];
    }
    
//    NSLog(@"celldata %@", cell.cellData);
//    [cell createCell];
//    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    
    return cell;
}




#pragma mark socketControllerDelegate
-(void)readData:(NSData *)data remoteType:(NSString *)type
{
    NSLog(@"dataStrasd %@", data);
    Byte *singleByte = (Byte *)[data bytes];
    if (singleByte[0] == 0x01) {
        [SOCKETLAST.singleArr addObject:data];
        NSLog(@"dataStr %@ %@", data, SOCKETLAST.singleArr);
        [self.tableView reloadData];
    }
}

-(void)socketStatus:(BOOL)status
{
    NSLog(@"login socketStatus");
}



@end
