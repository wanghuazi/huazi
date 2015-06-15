//
//  editSingleViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/18.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "editSingleViewController.h"
#import "Header.h"
#import "CustomView.h"
#import "CustomViewYuan.h"
#import "public.h"
#import "timeViewController.h"


@interface editSingleViewController ()

@end

@implementation editSingleViewController
@synthesize singleData;

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"DET-04"]]];
    [self.tabBarController.tabBar setHidden:YES];
    self.title = @"单灯编辑";
    
    SOCKETLAST.delegate = self;
    singleByte = (Byte*)[self.singleData bytes];
    [self requestColor];
    
    //修改navigattionbar
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    //修改leftBarButtonItem样式
    UIImageView *itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backward_btn"]];
    UITapGestureRecognizer *goBackTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goback)];
    itemImageView.userInteractionEnabled = YES;
    [itemImageView addGestureRecognizer:goBackTap];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:itemImageView];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //light info row
    UIView *infoTitle = [[UIView alloc] initWithFrame:CGRectMake(0, APP_HEIGHT*0.13, APP_WIDTH, APP_HEIGHT*0.13)];
    [self.view addSubview:infoTitle];
    //light Component
    UIImageView *lightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH*0.22, APP_HEIGHT*0.11)];
    lightImgView.image = [UIImage imageNamed:@"deng"];
    [infoTitle addSubview:lightImgView];
    
    UILabel *lightTitle = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH*0.22 + 10, 12, 150, 20)];
    lightTitle.text = @"7w灯泡";
    [infoTitle addSubview:lightTitle];
    UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH*0.22 + 10, 35, 50, 20)];
    colorLabel.text = @"颜色";
    [infoTitle addSubview:colorLabel];
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(APP_WIDTH*0.18+ 60, 35, 20, 20)];
    customView.isRing = true;
    customView.color = RGB(255, 0, 0, 0.8);
    [infoTitle addSubview:customView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_HEIGHT*0.255, APP_WIDTH, 1)];
    lineView.backgroundColor = RGB(212, 214, 214, 0.6);
    [self.view addSubview:lineView];
    
    
    UILabel *colorText = [[UILabel alloc] initWithFrame:CGRectMake(20, APP_HEIGHT*0.453, APP_WIDTH-20, APP_HEIGHT*0.0176)];
    colorText.text = @"颜色";
    [self.view addSubview:colorText];
    
    colorSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, APP_HEIGHT*0.493, 300, 15)];
    colorSlider.value = 0.5;
    colorSlider.maximumTrackTintColor = [UIColor clearColor];
    colorSlider.minimumTrackTintColor = [UIColor clearColor];
    colorImage = [UIImage imageNamed:@"color_bar"];
    [colorSlider setBackgroundColor:[UIColor colorWithPatternImage:colorImage]];
    [self.view addSubview:colorSlider];
    [colorSlider addTarget:self action:@selector(colorChange) forControlEvents:UIControlEventValueChanged];
    
    showColorView = [[CustomViewYuan alloc] initWithFrame:CGRectMake(110, APP_HEIGHT*0.28, APP_HEIGHT*0.1585, APP_HEIGHT*0.1585)];
    [self.view addSubview:showColorView];
    [self colorChange];
    
    UILabel *brightText = [[UILabel alloc] initWithFrame:CGRectMake(20, APP_HEIGHT*0.555, APP_WIDTH-20, APP_HEIGHT*0.0176)];
    brightText.text = @"亮度";
    [self.view addSubview:brightText];
    
    brightSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, APP_HEIGHT*0.594, 300, 15)];
    brightSlider.value = 0.5;
    brightSlider.maximumTrackTintColor = [UIColor clearColor];
    brightSlider.minimumTrackTintColor = [UIColor clearColor];
    brightImage = [UIImage imageNamed:@"grey_bar"];
    [brightSlider setBackgroundColor:[UIColor colorWithPatternImage:brightImage]];
    [self.view addSubview:brightSlider];
    
    UILabel *saturationText = [[UILabel alloc] initWithFrame:CGRectMake(20, APP_HEIGHT*0.65, APP_WIDTH-20, APP_HEIGHT*0.0176)];
    saturationText.text = @"饱和度";
    [self.view addSubview:saturationText];
    
    saturationSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, APP_HEIGHT*0.695, 300, 15)];
    saturationSlider.value = 0.5;
    saturationSlider.maximumTrackTintColor = [UIColor clearColor];
    saturationSlider.minimumTrackTintColor = [UIColor clearColor];
    UIImage *saturationImage = [UIImage imageNamed:@"grey_bar"];
    [saturationSlider setBackgroundColor:[UIColor colorWithPatternImage:saturationImage]];
    [self.view addSubview:saturationSlider];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_HEIGHT*0.792, APP_WIDTH, APP_HEIGHT*0.0616)];
    [self.view addSubview:timeView];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH*0.0312, 0, 150, APP_HEIGHT*0.0616)];
    timeLabel.text = @"定期开关";
    [timeView addSubview:timeLabel];
    
    UIImageView *openImg = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH*0.8, 0, 34, 34)];
    openImg.image = [UIImage imageNamed:@"on_btn"];
    [timeLabel addSubview:openImg];
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setOpen)];
    [openImg addGestureRecognizer:tapgesture];
    
    
    UIButton *hourTextfield = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH*0.0312, APP_HEIGHT*0.889, APP_WIDTH*0.375, APP_HEIGHT*0.07)];
    hourTextfield.backgroundColor = RGB(214,216,217,1);
    [self.view addSubview:hourTextfield];
    [hourTextfield addTarget:self action:@selector(setTimeViewFunction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH*0.47, APP_HEIGHT*0.889, 20, APP_HEIGHT*0.07)];
    textLabel.text = @"至";
    [self.view addSubview:textLabel];
    
    UIButton *minuteTextfield = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH*0.586, APP_HEIGHT*0.889, APP_WIDTH*0.375, APP_HEIGHT*0.07)];
    minuteTextfield.backgroundColor = RGB(214,216,217,1);
    [self.view addSubview:minuteTextfield];
    [minuteTextfield addTarget:self action:@selector(setTimeViewFunction) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *changeUserName = [[UIButton alloc] init];
//    changeUserName.frame = CGRectMake(10, 300, 100, 100);
//    changeUserName.backgroundColor = [UIColor redColor];
//    [self.view addSubview:changeUserName];
//    [changeUserName addTarget:self action:@selector(changeUserName) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark get single info
-(void)requestColor
{
    NSData *colorData;
    if (SOCKETLAST.typeSocket == 1) {
        Byte colorByte[] = {0x0E, 0x00, 0x0c, 0x00,0x08, 0x00,0x08, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x81};
        colorData = [[NSData alloc] initWithBytes:colorByte length:sizeof(colorByte)];
    } else {
        Byte colorByte[] = {0x15, 0x00, SOCKETLAST.sn4, SOCKETLAST.sn3, SOCKETLAST.sn2, SOCKETLAST.sn1, 0xFE, 0x87, 0x0c, 0x02, singleByte[2],singleByte[3], 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00};
        colorData = [[NSData alloc] initWithBytes:colorByte length:sizeof(colorByte)];
        NSLog(@"switchSendData %@ %lu", colorData, sizeof(colorByte));
    }
    
    [SOCKETLAST writeData:colorData];
    
}

- (void)setOpen
{
    //    Byte byte[] = {0x10,0x00,0x0c,0x00,0x10,0x00,0x10,0x00,0xFF,0xFF,0xFF,0xFF,0xFE,0x94,0x7,0xf3,0x55,0x0B,0x03,0x61,0x62,0x63};
    NSData *adata;
    if (SOCKETLAST.typeSocket == 1) {
       Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    } else {
       Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    }
    
    [SOCKETLAST writeData:adata];
    NSLog(@"changeUserName %@", adata);
}

- (void)changeUserName
{
//    Byte byte[] = {0x10,0x00,0x0c,0x00,0x10,0x00,0x10,0x00,0xFF,0xFF,0xFF,0xFF,0xFE,0x94,0x7,0xf3,0x55,0x0B,0x03,0x61,0x62,0x63};
//    Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
//    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
//    [SOCKETLAST writeData:adata];
//    NSLog(@"changeUserName %@ %lu", adata, sizeof(byte));
}

- (void)setTimeViewFunction
{NSLog(@"setTimeViewFunction");
    [self.navigationController.navigationBar setHidden:YES];
    timeView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    timeView.backgroundColor = [UIColor blackColor];
    [timeView setAlpha:0.8];
    [self.view addSubview:timeView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, APP_WIDTH, 20)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"输入开始时间"];
    [timeView addSubview:titleLabel];
    
    UILabel *hourTextField = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 70, 70)];
    if (!hourStr) {
        hourStr = @"00";
    }
    [hourTextField setTextAlignment:NSTextAlignmentCenter];
    hourTextField.backgroundColor = [UIColor whiteColor];
    hourTextField.text = hourStr;
    [timeView addSubview:hourTextField];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 20, 80, 40)];
    closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn addTarget:self action:@selector(closeTimeView) forControlEvents:UIControlEventTouchUpInside];
    [timeView addSubview:closeBtn];
}

#pragma mark - close function
- (void)closeTimeView
{
    [timeView removeFromSuperview];
}


#pragma mark - sigle control

- (void)colorChange
{
    CGPoint point = CGPointMake(600*colorSlider.value, 7);
    UIColor *lightColor = [public getPixelColorAtLocation:point image:colorImage];
//    showColorView.backgroundColor = lightColor;
    showColorView.color = lightColor;
    [showColorView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark socketControllerDelegate
-(void)readData:(NSData *)data remoteType:(NSString *)type
{
//    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"colordataStr %@", data);
    //    self.titles =  @[dataStr];
}

-(void)socketStatus:(BOOL)status
{
    NSLog(@"login socketStatus");
}

@end
