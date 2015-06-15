//
//  sigleCellTableViewCell.m
//  detapp
//
//  Created by wanghaohua on 15/5/20.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "sigleTableViewCell.h"
#import "CustomView.h"
#import "Header.h"
#import "public.h"

@implementation sigleTableViewCell
@synthesize cellData;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        return self;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setOpen
{
    Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    [SOCKETLAST writeData:adata];
}

- (void)createCell:(NSData*)data{
    
    if (data) {
        
        
        Byte *singleByte = (Byte*)[data bytes];
        Byte nameByte[singleByte[10]];
        for (integer_t i=0; i<singleByte[10]; i++) {
            nameByte[i] = singleByte[11+i];
        }
        NSData *asdata = [[NSData alloc] initWithBytes:nameByte length:sizeof(nameByte)];
        NSString *nameStr = [public stringGB2312FromHex:asdata];
        NSLog(@"nameStr %@ %@", nameStr, data);
        UILabel *infoTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 17, 150, 20)];
        infoTitle.text = nameStr;
        [self.contentView addSubview:infoTitle];
        
//        NSData *switchSendData;
//        if (SOCKETLAST.typeSocket == 1) {
//            Byte byte[] = {0x0E, 0x00, 0x0c, 0x00,0x08, 0x00,0x08, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x81};
//            switchSendData = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
//        } else {
//            Byte byte[] = {0x15, 0x00, SOCKETLAST.sn4, SOCKETLAST.sn3, SOCKETLAST.sn2, SOCKETLAST.sn1, 0xFE, 0x87, 0x0c, 0x02, singleByte[2], singleByte[3], 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00};
//            switchSendData = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
//        }
//        [SOCKETLAST writeData:switchSendData];
//        SOCKETLAST.delegate = self;
        
        
        UIImage *leftImage = [UIImage imageNamed:@"deng"];
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 70, 70)];
        leftImageView.image = leftImage;
        [self.contentView addSubview:leftImageView];
        
        
        UILabel *colorInfo = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 40, 20)];
        colorInfo.text = @"颜色";
        [self.contentView addSubview:colorInfo];
        
        CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(120, 40, 20, 20)];
        [self.contentView addSubview:customView];
        customView.isRing = true;
        customView.color = RGB(255, 0, 0, 0.8);
        
        UIButton *openControl = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH-50, 20, 30, 30)];
        [openControl setBackgroundImage:[UIImage imageNamed:@"on_btn"] forState:UIControlStateNormal];
        [openControl addTarget:self action:@selector(setOpen) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:openControl];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Configure the view for the selected state
}

//#pragma mark socketControllerDelegate
//-(void)readData:(NSData *)data remoteType:(NSString *)type
//{NSLog(@"sigleTableViewCell %@", data);
//    Byte *singleByte = (Byte *)[data bytes];
//    if (singleByte[0] == 0x09) {
//        NSLog(@"sigleTableViewCell %@", data);
//    }
//}
//
//-(void)socketStatus:(BOOL)status
//{
//    NSLog(@"login socketStatus");
//}

@end
