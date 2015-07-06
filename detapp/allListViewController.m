//
//  allListViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/12.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "allListViewController.h"
#import "NDNavigationController.h"
#import "Header.h"
#import "singleViewController.h"
#import "doubleViewController.h"
#import "sceneViewController.h"
#import "AppDelegate.h"
#import "NDMenuViewController.h"


@interface allListViewController ()

@end

@implementation allListViewController
@synthesize tabbarController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_background"]]];
    }
    return  self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    UIImageView *itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_btn"]];
    UITapGestureRecognizer *goBackTap = [[UITapGestureRecognizer alloc] initWithTarget:(NDNavigationController *)self.navigationController action:@selector(showMenu)];
    itemImageView.userInteractionEnabled = YES;
    [itemImageView addGestureRecognizer:goBackTap];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:itemImageView];
    self.navigationItem.leftBarButtonItem = backButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //获取单灯数据
//    NSData *adata;
//    if (SOCKETLAST.typeSocket == 1) {
//        Byte byte[] = {0x0E, 0x00, 0x0c, 0x00,0x08, 0x00,0x08, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x81};
//        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
//    } else {
//        Byte byte[] = {0x08, 0x00, SOCKETLAST.sn4, SOCKETLAST.sn3, SOCKETLAST.sn2, SOCKETLAST.sn1, 0xFE, 0x81};
//        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
//    }
//    
//    BOOL abcd = [SOCKETLAST writeData:adata];
//    SOCKETLAST.delegate = self;
//    NSLog(@"SOCKETLAST %d and %@", abcd, adata);
    //single controller
    UIImageView *single = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"single_ctrl_round_btn_off"]];
    single.frame = CGRectMake((APP_WIDTH - APP_HEIGHT*0.1637)/2, APP_HEIGHT*0.132, APP_HEIGHT*0.1637, APP_HEIGHT*0.1637);
    single.tag = 1;
    single.userInteractionEnabled = YES;
    [self.view addSubview:single];
    UITapGestureRecognizer *singleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sceneList:)];
    [single addGestureRecognizer:singleGesture];
    
    UILabel *singleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, APP_HEIGHT*0.308, APP_WIDTH, 15)];
    singleLabel.text = @"单灯控制";
    singleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:singleLabel];
    
    //double controller
    UIImageView *doublecontroller = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"multi-light_control_off"]];
    doublecontroller.frame = CGRectMake((APP_WIDTH - APP_HEIGHT*0.1637)/2, APP_HEIGHT*0.396, APP_HEIGHT*0.1637, APP_HEIGHT*0.1637);
    doublecontroller.tag = 2;
    doublecontroller.userInteractionEnabled = YES;
    [self.view addSubview:doublecontroller];
    UITapGestureRecognizer *doubleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sceneList:)];
    [doublecontroller addGestureRecognizer:doubleGesture];
    
    UILabel *doubleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, APP_HEIGHT*0.572, APP_WIDTH, 15)];
    doubleLabel.text = @"组合控制";
    doubleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:doubleLabel];
    
    //double controller
    UIImageView *sceneController = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"function_off"]];
    sceneController.frame = CGRectMake((APP_WIDTH - APP_HEIGHT*0.1637)/2, APP_HEIGHT*0.665, APP_HEIGHT*0.1637, APP_HEIGHT*0.1637);
    sceneController.tag = 3;
    sceneController.userInteractionEnabled = YES;
    UITapGestureRecognizer *sceneGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sceneList:)];
    
    [sceneController addGestureRecognizer:sceneGesture];
    [self.view addSubview:sceneController];
    
    UILabel *sceneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, APP_HEIGHT*0.845, APP_WIDTH, 15)];
    sceneLabel.text = @"情景控制";
    sceneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:sceneLabel];
    
}

- (void)sceneList:(id)sender
{
    UIView *viewT = [sender view];
    unsigned long index = viewT.tag;
    BOOL isContent = false;
    if (index == 1) {
//        isContent = true;
        Byte byte[14];
        byte[0] = 0x0E;
        byte[1] = 0x00;
        byte[2] = 0x0C;
        byte[3] = 0x00;
        
        byte[4] = 0x08;
        byte[5] = 0x00;
        
        byte[4] = 0x08;
        byte[5] = 0x00;
//        NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
//        if ([SOCKETLAST writeData:adata]) {
//            return YES;
//        } else {
//            return NO;
//        }
    }
    isContent = true;
    if (isContent) {
        [self enterView:index];
    } else {
        NSLog(@"内容有错");
    }
}


- (void)enterView:(NSInteger)index
{
    NDNavigationController *navigationController = [[NDNavigationController alloc] initWithRootViewController:[[allListViewController alloc] initWithNibName:@"allListViewController" bundle:nil]];
    
    NDMenuViewController *menuController = [[NDMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.menuViewSize = CGSizeMake(APP_WIDTH*0.4, APP_HEIGHT);
    
    singleViewController *singleView = [[singleViewController alloc] initWithNibName:@"singleViewController" bundle:nil];
//    testViewController *singleView = [[testViewController alloc] initWithNibName:@"testViewController" bundle:nil];
    UINavigationController *singleNavigation = [[UINavigationController alloc] initWithRootViewController:singleView];
    doubleViewController *doubleView = [[doubleViewController alloc] initWithNibName:@"doubleViewController" bundle:nil];
    UINavigationController *doubleNavigation = [[UINavigationController alloc] initWithRootViewController:doubleView];
    sceneViewController *scenceView = [[sceneViewController alloc] initWithNibName:@"sceneViewController" bundle:nil];
    UINavigationController *scenceNavigation = [[UINavigationController alloc] initWithRootViewController:scenceView];
    tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = [NSArray arrayWithObjects:frostedViewController, singleNavigation, doubleNavigation, scenceNavigation, nil];
    tabbarController.selectedViewController = [tabbarController.viewControllers objectAtIndex:index];
    UITabBar *tabBar = tabbarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    tabBarItem1.title = @"首页";
    tabBarItem1.image = [UIImage imageNamed:@"mainpage_off123"];
    tabBarItem2.title = @"单灯控制";
    tabBarItem2.image = [UIImage imageNamed:@"single_light_control_on123"];
    tabBarItem3.title = @"组合控制";
    tabBarItem3.image = [UIImage imageNamed:@"multi-light_control_off123"];
    tabBarItem4.title = @"情景控制";
    tabBarItem4.image = [UIImage imageNamed:@"function_off123"];
    
    AppDelegate *appdeleget = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tabbarController.delegate = appdeleget;
    appdeleget.window.rootViewController = tabbarController;
    [appdeleget.window makeKeyAndVisible];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    viewController.view.backgroundColor=[UIColor blackColor];
}

- (void)singleList
{
    
}

- (void)doubleList
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark socketControllerDelegate
//-(void)readData:(NSData *)data remoteType:(NSString *)type
//{
//    [SOCKETLAST.singleArr addObject:data];
//    NSLog(@"alllistView %@ %@", data, SOCKETLAST.singleArr);
//    //    self.titles =  @[dataStr];
//}
//
//-(void)socketStatus:(BOOL)status
//{
//    NSLog(@"login socketStatus");
//}

@end
