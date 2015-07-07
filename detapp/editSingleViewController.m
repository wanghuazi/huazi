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


@interface editSingleViewController ()

@end

@implementation editSingleViewController
@synthesize singleData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarController.tabBar setHidden:YES];
    self.title = @"单灯编辑";
    
    SOCKETLAST.delegate = self;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_background"]]];
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
    
    singleInfo = [self.singleData firstObject];
    singleByte = (Byte*)[singleInfo bytes];
    integer_t onlineOfOrder = 11 + singleByte[10];
    
    if (singleByte[onlineOfOrder] != 0x00) { //判断灯是否在线
    
    Byte nameByte[singleByte[10]];
    for (integer_t i=0; i<singleByte[10]; i++) {
        nameByte[i] = singleByte[11+i];
    }
    NSData *asdata = [[NSData alloc] initWithBytes:nameByte length:sizeof(nameByte)];
    NSString *nameStr = [public stringGB2312FromHex:asdata];
    
    
    openInfo = [self.singleData objectAtIndex:1];
    Byte *openByte = (Byte *)[openInfo bytes];
    if (openByte[5] == 0x01) {
        isLight = 1;
    } else if(openByte[5] == 0x00) {
        isLight = 0;
    }
    
    
    
    //light info row
    UIView *infoTitle = [[UIView alloc] initWithFrame:CGRectMake(0, APP_HEIGHT*0.13, APP_WIDTH, APP_HEIGHT*0.13)];
    [self.view addSubview:infoTitle];
    //light Component
    UIImageView *lightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH*0.22, APP_HEIGHT*0.11)];
    lightImgView.image = [UIImage imageNamed:@"deng"];
    [infoTitle addSubview:lightImgView];
    
    UILabel *lightTitle = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH*0.22 + 10, 12, 150, 20)];
    lightTitle.text = nameStr;
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
    [colorSlider addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    
    
    showColorView = [[CustomViewYuan alloc] initWithFrame:CGRectMake(110, APP_HEIGHT*0.28, APP_HEIGHT*0.1585, APP_HEIGHT*0.1585)];
    showColorView.color = RGB(195, 56, 255, 1);
    [self.view addSubview:showColorView];
    
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
    
    openImg = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH*0.8, 0, 34, 34)];
    if (isLight == 1) {
        [openImg setBackgroundImage:[UIImage imageNamed:@"on_btn"] forState:UIControlStateNormal];
    } else {
        [openImg setBackgroundImage:[UIImage imageNamed:@"off_btn"] forState:UIControlStateNormal];
    }
    
    [openImg addTarget:self action:@selector(setOpen:) forControlEvents:UIControlEventTouchUpInside];
    [timeView addSubview:openImg];
    
    
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
    } else {
        UIButton *bingBtn = [[UIButton alloc] initWithFrame:CGRectMake((APP_WIDTH-200)/2, APP_HEIGHT*0.3, 200, 50)];
        [bingBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [bingBtn setTintColor:[UIColor whiteColor]];
        bingBtn.backgroundColor = [UIColor redColor];
        [bingBtn addTarget:self action:@selector(bingSingle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bingBtn];
    }
//    UIButton *changeUserName = [[UIButton alloc] init];
//    changeUserName.frame = CGRectMake(10, 300, 100, 100);
//    changeUserName.backgroundColor = [UIColor redColor];
//    [self.view addSubview:changeUserName];
//    [changeUserName addTarget:self action:@selector(changeUserName) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bingSingle
{
    NSData *bingData;
    NSInteger IEEE = 12+singleByte[10];
    
    if (SOCKETLAST.typeSocket == 1) {
        Byte byte[] = {0x0E, 0x00, 0x0c, 0x00,0x08, 0x00,0x08, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x81};
        bingData = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    } else {
        Byte byte[] = {0x1F, 0x00, SOCKETLAST.sn4, SOCKETLAST.sn3, SOCKETLAST.sn2, SOCKETLAST.sn1, 0xFE, 0x89,0x04,singleByte[2],singleByte[3],0x0B,singleByte[IEEE],singleByte[IEEE+1],singleByte[IEEE+2],singleByte[IEEE+3],singleByte[IEEE+4],singleByte[IEEE+5],singleByte[IEEE+6],singleByte[IEEE+7],0x0D,singleByte[IEEE],singleByte[IEEE+1],singleByte[IEEE+2],singleByte[IEEE+3],singleByte[IEEE+4],singleByte[IEEE+5],singleByte[IEEE+6],singleByte[IEEE+7],0x06,0x04};
        bingData = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    }
    
    BOOL sisd = [SOCKETLAST writeData:bingData];
    NSLog(@"bingSingle %@ and %d", bingData, sisd);
}

- (void)goback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark get single info
//-(void)getOpen
//{
//    NSData *colorData;
//    if (SOCKETLAST.typeSocket == 1) {
//        Byte colorByte[] = {0x0E, 0x00, 0x0c, 0x00,0x08, 0x00,0x08, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x81};
//        colorData = [[NSData alloc] initWithBytes:colorByte length:sizeof(colorByte)];
//    } else {
//        Byte colorByte[] = {0x15, 0x00, SOCKETLAST.sn4, SOCKETLAST.sn3, SOCKETLAST.sn2, SOCKETLAST.sn1, 0xFE, 0x85, 0x0C, 0x02, singleByte[2],singleByte[3], 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00};
//        colorData = [[NSData alloc] initWithBytes:colorByte length:sizeof(colorByte)];
//    }
//    
//    [SOCKETLAST writeData:colorData];
//}


- (void)setOpen:(id)sender
{
    NSData *adata;
    if (SOCKETLAST.typeSocket == 1) {
       Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    } else {
        if (isLight == 0) {
            Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,singleByte[2],singleByte[3],0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x01};
            adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
            isLight = 1;
            [openImg setBackgroundImage:[UIImage imageNamed:@"on_btn"] forState:UIControlStateNormal];
        } else if (isLight == 1) {
            Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,singleByte[2],singleByte[3],0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
            adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
            isLight = 0;
            [openImg setBackgroundImage:[UIImage imageNamed:@"off_btn"] forState:UIControlStateNormal];
        }
    }
    
    [SOCKETLAST writeData:adata];
}

- (void)changeUserName
{
//    Byte byte[] = {0x10,0x00,0x0c,0x00,0x10,0x00,0x10,0x00,0xFF,0xFF,0xFF,0xFF,0xFE,0x94,0x7,0xf3,0x55,0x0B,0x03,0x61,0x62,0x63};
    Byte byte[] = {0x19,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x84,0x10,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    [SOCKETLAST writeData:adata];
    NSLog(@"changeUserName %@ %lu", adata, sizeof(byte));
}

- (void)changeColor
{
    CGPoint point = CGPointMake(600*colorSlider.value, 7);
    UIColor *lightColor = [public getPixelColorAtLocation:point image:colorImage];
    
    const CGFloat* components = CGColorGetComponents(lightColor.CGColor);
    const CGFloat *colorValue = [self rgbToHsl:components];//颜色，亮度，饱和度
    const float colorSB = colorValue[0];
    const float colorSC = colorValue[2];
    Byte colorHex = strtoul([[public ToHex:colorSB] UTF8String],0,16);
    Byte lightHex = strtoul([[public ToHex:colorSC] UTF8String],0,16);

    
    Byte byte[] = {0x19,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x84,0x10,0x02,singleByte[2],singleByte[3],0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,colorHex,lightHex,0x00,0x00};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    [SOCKETLAST writeData:adata];
}

//- (void)setTimeViewFunction
//{NSLog(@"setTimeViewFunction");
//    [self.navigationController.navigationBar setHidden:YES];
//    timeView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    timeView.backgroundColor = [UIColor blackColor];
//    [timeView setAlpha:0.8];
//    [self.view addSubview:timeView];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, APP_WIDTH, 20)];
//    [titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [titleLabel setTextColor:[UIColor whiteColor]];
//    [titleLabel setText:@"输入开始时间"];
//    [timeView addSubview:titleLabel];
//    
//    UILabel *hourTextField = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 70, 70)];
//    if (!hourStr) {
//        hourStr = @"00";
//    }
//    [hourTextField setTextAlignment:NSTextAlignmentCenter];
//    hourTextField.backgroundColor = [UIColor whiteColor];
//    hourTextField.text = hourStr;
//    [timeView addSubview:hourTextField];
//    
//    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 20, 80, 40)];
//    closeBtn.backgroundColor = [UIColor redColor];
//    [closeBtn addTarget:self action:@selector(closeTimeView) forControlEvents:UIControlEventTouchUpInside];
//    [timeView addSubview:closeBtn];
//}


/**
 * 把颜色转为色调（hsl）
 *
 * @param rgb
 * @return
 */
-(CGFloat*)rgbToHsl:(CGFloat*)arr
{
    CGFloat btyeRGB[3];
//    NSMutableArray *rgbValueArr = [NSMutableArray array];
//    NSInteger rInt = [arr objectAtIndex:0];
    CGFloat R = arr[0];
//    NSInteger gInt = [arr objectAtIndex:1];
    CGFloat G = arr[1];
    
//    NSInteger bInt = [arr objectAtIndex:2];
    CGFloat B = arr[2];
    CGFloat max, min,diff, r_dist, g_dist, b_dist;
    max = MAX(MAX(R, G), B);
    min = MIN(MIN(R, G), B);
    diff = max - min;
    btyeRGB[2] = (max + min) / 2*100;
    if (diff == 0.f) {
        btyeRGB[0] = 0.f;
        btyeRGB[1] = 0.f;
    } else {
        if (btyeRGB[2] < 0.5) {NSLog(@"diff = 0.5");
            btyeRGB[1] = (diff / (max + min)) * 100;
        } else {
            btyeRGB[1] = diff / ((2 - max - min)) * 100;
        }
        r_dist = (max - R) / diff;
        g_dist = (max - G) / diff;
        b_dist = (max - B) / diff;
        if (R == max) {
            btyeRGB[0] = b_dist - g_dist;
        } else if (G == max) {
            btyeRGB[0] = 2 + r_dist - b_dist;
        } else if (B == max) {
            btyeRGB[0] = 4 + g_dist - r_dist;
        }
        btyeRGB[0] = btyeRGB[0] * 60;
        if (btyeRGB[0] < 0) {
            btyeRGB[0] += 360;
        }
        if (btyeRGB[0] >= 360) {
            btyeRGB[0] -= 360;
        }
    }
    return btyeRGB;
}

//-(void) getHsl:(NSArray*)arr {
////    float[] hsl = new float[3];
//    
//    float R = arr[0] / 255.f;
//    float G = arr[1] / 255.f;
//    float B = arr[2] / 255.f;
//    float max, min, diff, r_dist, g_dist, b_dist;
//    max = Math.max(Math.max(R, G), B);
//    min = Math.min(Math.min(R, G), B);
//    diff = max - min;
//    hsl[2] = (max + min) / 2*100;
//    if (diff == 0.f) {
//        hsl[0] = 0.f;
//        hsl[1] = 0.f;
//    } else {
//        if (hsl[2] < 0.5) {
//            hsl[1] = (diff / (max + min)) * 100;
//        } else {
//            hsl[1] = diff / ((2 - max - min)) * 100;
//        }
//        r_dist = (max - R) / diff;
//        g_dist = (max - G) / diff;
//        b_dist = (max - B) / diff;
//        if (R == max) {
//            hsl[0] = b_dist - g_dist;
//        } else if (G == max) {
//            hsl[0] = 2 + r_dist - b_dist;
//        } else if (B == max) {
//            hsl[0] = 4 + g_dist - r_dist;
//        }
//        hsl[0] = hsl[0] * 60;
//        if (hsl[0] < 0) {
//            hsl[0] += 360;
//        }
//        if (hsl[0] >= 360) {
//            hsl[0] -= 360;
//        }
//
//    }
//    return hsl;
//}

- (void)setTimeViewFunction
{
    TimeViewController *timeViewC = [[TimeViewController alloc] init];
    timeViewC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:timeViewC];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    nav.view.backgroundColor = [UIColor blackColor];
    [nav.view setAlpha:0.8];
//    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:NO completion:nil];
}

-(void)timerSetSingle:(NSDate *)timeStr
{
    NSTimeInterval futureInterval = [timeStr timeIntervalSinceNow];
    [NSTimer scheduledTimerWithTimeInterval:futureInterval target:self selector:@selector(setOpen:) userInfo:nil repeats:NO];
    NSLog(@"timeStr %f", futureInterval);
}

#pragma mark - sigle control

- (void)colorChange
{
    CGPoint point = CGPointMake(600*colorSlider.value, 7);
    UIColor *lightColor = [public getPixelColorAtLocation:point image:colorImage];
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
    NSLog(@"socketController %@", data);
//    Byte *singleByte = (Byte *)[data bytes];
//    if (singleByte[0] == 0x07) {
//        if (singleByte[5] == 0x01) {
//            isLight = 1;
//            [openImg setBackgroundImage:[UIImage imageNamed:@"on_btn"] forState:UIControlStateNormal];
//        } else if(singleByte[5] == 0x00) {
//            isLight = 0;
//            [openImg setBackgroundImage:[UIImage imageNamed:@"off_btn"] forState:UIControlStateNormal];
//        } else {
//            isLight = 2;
//        }
//    }
}

-(void)socketStatus:(BOOL)status
{
    NSLog(@"login socketStatus");
}

@end
