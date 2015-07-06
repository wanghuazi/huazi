//
//  scoketController.h
//  detapp
//
//  Created by wanghaohua on 15/5/16.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "AsyncUdpSocket.h"

@protocol socketControllerDelegate<NSObject>

@optional
- (void)readData:(NSData *)data remoteType:(NSString*)type;
- (void)socketStatus:(BOOL)status;
@end

@interface socketController : NSObject<AsyncUdpSocketDelegate, AsyncSocketDelegate>
{
    AsyncUdpSocket *_asyncUdpSocket;
    AsyncSocket *_asyncSocket;
}
//@property (nonatomic, retain) AsyncUdpSocket *asyncUdpSocket;
@property (nonatomic, retain) AsyncSocket *asyncSocket;
@property (nonatomic, retain) NSArray *snArr;
@property (nonatomic, retain) NSData *dataTmp;
@property (nonatomic, weak) id<socketControllerDelegate> delegate;
@property (nonatomic) unsigned long sn1;
@property (nonatomic) unsigned long sn2;
@property (nonatomic) unsigned long sn3;
@property (nonatomic) unsigned long sn4;
@property (nonatomic) integer_t typeSocket;  //1代表远程连接，2代表本地连接, 0代表还没有连接
@property (nonatomic, retain) NSMutableArray *singleArr;
@property (nonatomic, retain) NSMutableArray *doubleArr;

+(socketController *)initSockeController;
- (NSString *)getIPAddress;
- (void)sendUdpSocket;
- (void)getSingleList;
- (BOOL)writeData:(NSData *)data;
- (void)connect:(NSString *)host port:(NSInteger)port;

@end
