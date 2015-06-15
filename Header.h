//
//  Header.h
//  detapp
//
//  Created by wanghaohua on 15/5/6.
//  Copyright (c) 2015年 det. All rights reserved.
//
#import "AppDelegate.h"

#ifndef detapp_Header_h
#define detapp_Header_h

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define MAINBOUND [[UIScreen mainScreen] bounds]
#define APP_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define APP_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define PI 3.14159265358979323846
#define RGB(r,g,b,a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:a];

#define UDPPORT 9090
#define TCPPORT 8001
#define REMOTEPORT 8090
#define SOCKETLAST ([socketController initSockeController])

#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7

#define GETALLDEVICE        0x81
#define SETDEVICESWITCH     0x82
#define SETDEVICELEVEL      0x83
#define SETDEVICECOLOR      0x84
#define GETDEVICESWITCH     0x85
#define GETDEVICECOLOR      0x86
#define GETDEVICEHUE        0x87
#define GETDEVICESaturation        0x88
#define BINGDEVICE          0x89
#define GETMEMBERS          0x8A
#define DELETEMEMBERS       0x8B
#define GETGROUPS           0x8E
#define ADDGROUP            0x8F
#define GETSCENCE           0x90
#define ADDSCENCE           0x91
#define RECALLSCENCE        0x92
#define MODIFYNAME          0x94
#define DELETEDEVICE        0x95
#define UNBIND              0x96
#define DELETEGROUPDEVICE   0x97
#define GETGROUPNAME        0x98
#define GETTIMEING          0x99
#define ADDTIMEING          0x9A
#define DELETETIMEING       0x9B
#define MODIFYTIMEING       0x9C
#define GETGATEWAY          0x9D
#define SETPUSHTIME         0x9E







#endif
