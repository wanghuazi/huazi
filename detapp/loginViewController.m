//
//  loginViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/6.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "loginViewController.h"
#import "Header.h"
#import "forgetpwdViewController.h"
#import "allListViewController.h"
#import "NDMenuViewController.h"
#import "NDNavigationController.h"
#import "IPAdress.h"
#import "AppDelegate.h"
#import "scanViewController.h"
#import "public.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_background"]]];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SOCKETLAST.delegate = self;
    //忘记密码
    UILabel *forgetPwd = [[UILabel alloc] initWithFrame:CGRectMake((APP_WIDTH-100)*0.5 , APP_HEIGHT*0.85, 100, 20)];
    forgetPwd.text = @"忘记密码?";
    forgetPwd.font = [UIFont fontWithName:@"Arial" size:13];
    forgetPwd.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *forgetPwdTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPwdFunction)];
    forgetPwd.userInteractionEnabled = YES;
    [forgetPwd addGestureRecognizer:forgetPwdTap];
    [self.view addSubview:forgetPwd];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)remoteLgoin:(UIButton *)sender {
    
    if (![self.username.text isEqualToString:@""] && ![self.password.text isEqualToString:@""]) {
        [SOCKETLAST connect:@"www.fbeecloud.com" port:REMOTEPORT];
    } else {
        UIAlertView *getInfoAlert = [[UIAlertView alloc] initWithTitle:@"登陆" message:@"请填写用户名或密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [getInfoAlert show];
    }
}

- (IBAction)scanning:(id)sender {
    [self setupCamera];
}

- (IBAction)nameExit:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)pwdExit:(id)sender {
    [sender resignFirstResponder];
}
-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)localhostLogin:(id)sender {
    //send udp info and connnection
//    [SOCKETLAST sendUdpSocket];
//    [SOCKETLAST connect:@"10.1.1.29"];
    
//    [SOCKETLAST connect:@"192.168.1.105" port:UDPPORT];
//    NSString *aString = @"1234abcd";
//    NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
//    [SOCKETLAST writeData:aData];
    [SOCKETLAST sendUdpSocket];
//    [self createHomeView];
}



//- (IBAction)localhostLogin:(id)sender {
//    NDNavigationController *navigationController = [[NDNavigationController alloc] initWithRootViewController:[[allListViewController alloc] initWithNibName:@"allListViewController" bundle:nil]];
//    
//    NDMenuViewController *menuController = [[NDMenuViewController alloc] initWithStyle:UITableViewStylePlain];
//    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
//    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
//    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
//    frostedViewController.liveBlur = YES;
//    frostedViewController.delegate = self;
//    frostedViewController.menuViewSize = CGSizeMake(APP_WIDTH*0.4, APP_HEIGHT);
//    
//    [self.navigationController pushViewController:frostedViewController animated:YES];
////    AppDelegate *appdeleget = [[UIApplication sharedApplication] delegate];
////    appdeleget.window.rootViewController = frostedViewController;
//    
//}

- (void)createHomeView
{
    NDNavigationController *navigationController = [[NDNavigationController alloc] initWithRootViewController:[[allListViewController alloc] initWithNibName:@"allListViewController" bundle:nil]];
    
    NDMenuViewController *menuController = [[NDMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    frostedViewController.menuViewSize = CGSizeMake(APP_WIDTH*0.4, APP_HEIGHT);
    
    [self.navigationController pushViewController:frostedViewController animated:YES];
}

/**
 remote login
 */
- (BOOL)remotelgoinFunction:(NSString*)name password:(NSString *)pwd {
//    登陆飞比服务器
    unsigned long loginInfoInt = 7 + [name length] + [pwd length];
    unsigned long namePwdInt = [name length] + [pwd length] + 1;
    Byte byte[loginInfoInt];
    NSString *loginNumberStr = [public ToHex:loginInfoInt];
    NSString *namePwd = [public ToHex:namePwdInt];
    byte[0] = strtoul([loginNumberStr UTF8String],0,16);
    byte[1] = 0x00;
    byte[2] = 0x51;
    byte[3] = 0x00;
    byte[4] = strtoul([namePwd UTF8String],0,16);
    byte[5] = 0x00;
    integer_t headerInt = 6;
    integer_t headerAndNameInt = 7 + [name length];
    for (integer_t i=0; i<[name length]; i++) {
        byte[headerInt+i] = strtoul([[public ToHex:[name characterAtIndex:i]] UTF8String],0,16);
    }
    byte[headerAndNameInt-1] = 0x20;
    for (integer_t i=0; i<[pwd length]; i++) {
        byte[headerAndNameInt+i] = strtoul([[public ToHex:[pwd characterAtIndex:i]] UTF8String],0,16);
    }
    
//    Byte byte[] = {0x0b, 0x00, 0x51, 0x00, 0x05, 0x00, 0x31, 0x20, 0x78, 0x78, 0x78};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    if ([SOCKETLAST writeData:adata]) {
        return YES;
    } else {
        return NO;
    }
}




#pragma mark forget password
- (void)forgetPwdFunction
{
    forgetpwdViewController *forgetpwd = [[forgetpwdViewController alloc] initWithNibName:@"forgetpwdViewController" bundle:nil];
    [self.navigationController pushViewController:forgetpwd animated:YES];
}

#pragma mark socketControllerDelegate
-(void)readData:(NSData *)data remoteType:(NSString*)type
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"Heartbeat" object:self];
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *isLogin = [aStr componentsSeparatedByString:@"Login OK"];
    if ([type isEqual:@""]) {
        NSLog(@"login readData %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    } else {
        if ([type isEqual:@"80"]) {
            NSLog(@"remotelgoinFunction");
            [self remotelgoinFunction:self.username.text password:self.password.text];
            SOCKETLAST.typeSocket = 1;
        } else if (isLogin[1]) {
            [self createHomeView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Heartbeat" object:self];
        }
        
        NSLog(@"remoteType  %@", aStr);
    }
    
}

-(void)socketStatus:(BOOL)status
{
    NSLog(@"login typeSocket %d", SOCKETLAST.typeSocket);
    if (SOCKETLAST.typeSocket == 2 && status == 1) {
        [self createHomeView];
        
    }
}

#pragma mark scan function
-(void)setupCamera
{
    if(IOS7)
    {
        scanViewController * rt = [[scanViewController alloc]init];
        [self presentViewController:rt animated:YES completion:^{
            
        }];
        
    }
    else
    {
        [self scanBtnAction];
    }
}
-(void)scanBtnAction
{
    num = 0;
    upOrdown = NO;
    //初始话ZBar
    ZBarReaderViewController * reader = [ZBarReaderViewController new];
    //设置代理
    reader.readerDelegate = self;
    //支持界面旋转
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.showsHelpOnFail = NO;
    reader.scanCrop = CGRectMake(0.1, 0.2, 0.8, 0.8);//扫描的感应框
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25
                   config:ZBAR_CFG_ENABLE
                       to:0];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    view.backgroundColor = [UIColor clearColor];
    reader.cameraOverlayView = view;
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    label.text = @"请将扫描的二维码至于下面的框内\n谢谢！";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.lineBreakMode = 0;
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    image.frame = CGRectMake(20, 80, 280, 280);
    [view addSubview:image];
    
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [image addSubview:_line];
    //定时器，设定时间过1.5秒，
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    [self presentViewController:reader animated:YES completion:^{
        
    }];
}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (2*num == 260) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [timer invalidate];
    _line.frame = CGRectMake(30, 10, 220, 2);
    num = 0;
    upOrdown = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [timer invalidate];
    _line.frame = CGRectMake(30, 10, 220, 2);
    num = 0;
    upOrdown = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //初始化
        ZBarReaderController * read = [ZBarReaderController new];
        //设置代理
        read.readerDelegate = self;
        CGImageRef cgImageRef = image.CGImage;
        ZBarSymbol * symbol = nil;
        id <NSFastEnumeration> results = [read scanImage:cgImageRef];
        for (symbol in results)
        {
            break;
        }
        NSString * result;
        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
            
        {
            result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        else
        {
            result = symbol.data;
        }
        
        if (result) {    //判断扫描是否获取了二维码信息
            NSArray *username = [result componentsSeparatedByString:@"GT"];
            if (username[1]) {  //判断是否获取了用户名
                NSArray *pwd = [username[1] componentsSeparatedByString:@"pass"];
                if (pwd[1]) {   //判断是否获取了密码
                    [self remotelgoinFunction:username[1] password:pwd[1]];
                } else {
                    UIAlertView *getPwdAlert = [[UIAlertView alloc] initWithTitle:@"二维码登陆" message:@"用户名不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [getPwdAlert show];
                }
            } else {
                UIAlertView *getNameAlert = [[UIAlertView alloc] initWithTitle:@"二维码登陆" message:@"用户名不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [getNameAlert show];
            }
        } else {
            UIAlertView *getInfoAlert = [[UIAlertView alloc] initWithTitle:@"二维码登陆" message:@"二维码获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [getInfoAlert show];
        }
        NSLog(@"remotelgoinFunction %@",result);
    }];
}

@end
