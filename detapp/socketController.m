//
//  scoketController.m
//  detapp
//
//  Created by wanghaohua on 15/5/16.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "socketController.h"
#import "IPAdress.h"
#import "Header.h"
#import "AppDelegate.h"

@implementation socketController
//@synthesize udpSocket;
@synthesize asyncSocket=_asyncSocket;
@synthesize snArr;
@synthesize singleArr;

static socketController *socketConnect = nil;

-(id)init
{
    self = [super init];
    singleArr = [[NSMutableArray alloc] init];
    return self;
}

+(socketController *)initSockeController
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        socketConnect = [[self alloc] init];
    });
    return socketConnect;
}

#pragma mark IPAddress
- (NSString *)getIPAddress
{
    InitAddresses();
    GetIPAddresses();
    
    int i;
    NSString *deviceIP = nil;
    for (i=0; i<MAXADDRS; ++i)
    {
        static unsigned long localHost = 0x7F000001;            // 127.0.0.1
        unsigned long theAddr;
        
        theAddr = ip_addrs[i];
        
        if (theAddr == 0) break;
        if (theAddr == localHost) continue;
        
        deviceIP = [NSString stringWithFormat:@"%s", ip_names[i]];
    }
    
    return deviceIP;
}

-(void)notification:(NSString*)name result:(NSString *)result
{
    NSDictionary *diction = [NSDictionary dictionaryWithObjectsAndKeys:result, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:diction];
}

#pragma mark UdpSocket
//建立基于UDP的Socket连接
-(void)sendUdpSocket{
    //初始化udp
    _asyncUdpSocket=[[AsyncUdpSocket alloc] initWithDelegate:self];
    
    //绑定端口
    NSError *error = nil;
    [_asyncUdpSocket bindToPort:7070 error:&error];
    //设置可以广播
    [_asyncUdpSocket enableBroadcast:YES error:&error];
    
    NSString *detContext = @"GETIP\r\n";
    NSData *data = [detContext dataUsingEncoding:NSUTF8StringEncoding];
    [_asyncUdpSocket sendData:data toHost:@"255.255.255.255" port:UDPPORT withTimeout:-1 tag:1];
    //启动接收线程
    [_asyncUdpSocket receiveWithTimeout:-1 tag:0];
}

- (void)getSN:(NSString*)snStr
{
    NSRange range1 = NSMakeRange(0, 2);
    NSRange range2 = NSMakeRange(2, 2);
    NSRange range3 = NSMakeRange(4, 2);
    NSRange range4 = NSMakeRange(6, 2);
    
    self.sn1 = strtoul([[snStr substringWithRange:range1] UTF8String],0,16);
    self.sn2 = strtoul([[snStr substringWithRange:range2] UTF8String],0,16);
    self.sn3 = strtoul([[snStr substringWithRange:range3] UTF8String],0,16);
    self.sn4 = strtoul([[snStr substringWithRange:range4] UTF8String],0,16);
}

#pragma mark TCPsocket
- (void)connect:(NSString *)host port:(NSInteger)port
{
    NSError *errSocket = nil;
    _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    NSLog(@"typeSocket %d", _typeSocket);
    if(![_asyncSocket connectToHost:host onPort:port error:&errSocket])
    {
        NSLog(@"send request of connect error");
    }else{
        NSLog(@"send request of connect ok");
    }
    [_asyncSocket readDataWithTimeout:-1 tag:0];
}

- (BOOL)writeData:(NSData *)data{
    if (_asyncSocket) {
        [_asyncSocket writeData:data withTimeout:-1 tag:0];
        return YES;
    } else {
        return NO;
    }
}

//临时函数
- (void)getSingleList
{
//    unsigned long sn1 = strtoul([self.snArr[0] UTF8String],0,16);
//    unsigned long sn2 = strtoul([self.snArr[1] UTF8String],0,16);
//    unsigned long sn3 = strtoul([self.snArr[2] UTF8String],0,16);
//    unsigned long sn4 = strtoul([self.snArr[3] UTF8String],0,16);
//    Byte byte[] = {0x08, 0x00, sn4, sn3, sn2, sn1, 0xFE, 0x81};
    
    Byte byte[] = {0x08, 0x00, self.sn4, self.sn3, self.sn2, self.sn1, 0xFE, 0x81};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    NSLog(@"getSingleList %@", adata);
    [_asyncSocket writeData:adata withTimeout:-1 tag:0];
}

#pragma mark UPD delegate
//已接收到消息
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    NSString *udpResultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *udpResultArr = [udpResultStr componentsSeparatedByString:@"SN:"];
    NSLog(@"getSN %@", udpResultArr[1]);
    [self getSN:udpResultArr[1]];
    [self connect:host port:TCPPORT];
    self.typeSocket = 2;
    return YES;
}
//没有接受到消息
-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(socketStatus:)]) {
        [self.delegate socketStatus:NO];
    }
    NSLog(@"didNotReceiveDataWithTag");
}
//没有发送出消息
-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(socketStatus:)]) {
        [self.delegate socketStatus:NO];
    }
    NSLog(@"didNotSendDataWithTag");
}
//已发送出消息
-(void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"didSendDataWithTag");
}
//断开连接
-(void)onUdpSocketDidClose:(AsyncUdpSocket *)sock
{
    if ([self.delegate respondsToSelector:@selector(socketStatus:)]) {
        [self.delegate socketStatus:NO];
    }
    NSLog(@"onUdpSocketDidClose");
}

//释放定时器
- (void)timerFire
{
    [APPDELEGATE.myTimer invalidate];
    APPDELEGATE.myTimer = nil;
}

#pragma mark AsyncTcpScoket Delegate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    if ([self.delegate respondsToSelector:@selector(socketStatus:)]) {
        [self.delegate socketStatus:YES];
    }
    NSLog(@"didConnectToHost %@ and %hu", host, port);
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //    [sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];  // 这句话仅仅接收\r\n的数据
    NSLog(@"didWriteDataWithTag");
    [sock readDataWithTimeout:-1 tag:0];
    
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    Byte *typeByte = (Byte *)[data bytes];
    NSString *typeString = [NSString stringWithFormat:@"%d", typeByte[2]];
    
    NSArray *typeArr = [[NSArray alloc] initWithObjects:@"10", @"11", @"12", @"31", @"80", nil];
    NSData *dataString = nil;
    if ([typeArr containsObject:typeString]) {
        if ([typeString isEqual:@"31"]) {
            NSLog(@"heartinfo");
        } else {
        NSInteger dataStringLength = [data length] - 6;
        dataString = [data subdataWithRange:NSMakeRange(6, dataStringLength)];
        if ([self.delegate respondsToSelector:@selector(readData:remoteType:)]) {
            [self.delegate readData:dataString remoteType:typeString];
        }
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(readData:remoteType:)]) {
            [self.delegate readData:data remoteType:@""];
        }
    }
    
    NSLog(@"tcpdidReadData %@", data);
    [sock readDataWithTimeout:-1 tag:0];
    
}


- (void)onSocket:(AsyncSocket *)sock didSecure:(BOOL)flag
{
    NSLog(@"onSocket:%p didSecure:YES", sock);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    [self timerFire];
    if ([self.delegate respondsToSelector:@selector(socketStatus:)]) {
        [self.delegate socketStatus:NO];
    }
    NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    [self timerFire];
    if ([self.delegate respondsToSelector:@selector(socketStatus:)]) {
        [self.delegate socketStatus:NO];
    }
    //断开连接了
    NSLog(@"onSocketDidDisconnect:%p", sock);
}

@end
