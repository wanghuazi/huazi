//
//  AppDelegate.m
//  detapp
//
//  Created by wanghaohua on 15/4/29.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "AppDelegate.h"
#import "loginViewController.h"
#import "forgetpwdViewController.h"
#import "Header.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.frame = [[UIScreen mainScreen] bounds];
    loginViewController *login = [[loginViewController alloc] initWithNibName:@"loginViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = navController;
//    forgetpwdViewController *lgoin = [[forgetpwdViewController alloc] initWithNibName:@"forgetpwdViewController" bundle:nil];
//    self.window.rootViewController = lgoin;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerFunction) name:@"Heartbeat" object:nil];
    
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)timerFunction
{
     NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:40.0 target:self selector:@selector(HeartbeatLine) userInfo:nil repeats:YES];
    self.myTimer = timer;
}

- (void)HeartbeatLine
{
    Byte byte[] = {0x04, 0x00, 0x1E, 0x00};
    NSData *heartData = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    [SOCKETLAST writeData:heartData];
    NSLog(@"HeartbeatLine");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if (self.myTimer) {
        [self.myTimer setFireDate:[NSDate distantFuture]];
    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (self.myTimer) {
        [self.myTimer setFireDate:[NSDate distantPast]];
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
