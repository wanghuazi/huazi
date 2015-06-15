//
//  IPAdress.h
//  UDPServer
//
//  Created by wanghaohua on 15-1-9.
//  Copyright (c) 2015年 newnandu. All rights reserved.
//

#ifndef __UDPServer__IPAdress__
#define __UDPServer__IPAdress__

#include <stdio.h>

#define MAXADDRS    32

extern char *if_names[MAXADDRS];
extern char *ip_names[MAXADDRS];
extern char *hw_addrs[MAXADDRS];
extern unsigned long ip_addrs[MAXADDRS];

// Function prototypes

void InitAddresses();
void FreeAddresses();
void GetIPAddresses();
void GetHWAddresses();







#endif /* defined(__UDPServer__IPAdress__) */
