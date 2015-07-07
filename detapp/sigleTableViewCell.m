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
        openWithArr = [NSMutableArray array];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(80, 17, 150, 20)];
        title.tag = 201507061;
        [self.contentView addSubview:title];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 70, 70)];
        imageView.tag = 201507062;
        [self.contentView addSubview:imageView];
        
        UILabel *colorInfo = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 40, 20)];
        colorInfo.tag = 201507063;
        [self.contentView addSubview:colorInfo];
        
        CustomView *custom = [[CustomView alloc]initWithFrame:CGRectMake(120, 40, 20, 20)];
        custom.tag = 201507064;
        [self.contentView addSubview:custom];
        
        UIButton *openControl = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH-50, 20, 30, 30)];
        [openControl setTag:321];
        [self.contentView addSubview:openControl];
        
        return self;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setOpen:(id)sender
{
    if (openWithArr.count > 1) {
    Byte *openByte = (Byte *)[[openWithArr objectAtIndex:1] bytes];
    NSData *adata;
    if (SOCKETLAST.typeSocket == 1) {
        Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
        adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    } else {
        if (isLight == 0) {
            Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,openByte[2],openByte[3],0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x01};
            adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
            isLight = 1;
            
            [sender setBackgroundImage:[UIImage imageNamed:@"on_btn"] forState:UIControlStateNormal];
            [self setNeedsDisplay];
        } else if (isLight == 1) {
            Byte byte[] = {0x16,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0D,0x02,openByte[2],openByte[3],0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00,0x00};
            adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
            isLight = 0;
            [sender setBackgroundImage:[UIImage imageNamed:@"off_btn"] forState:UIControlStateNormal];
            [self setNeedsDisplay];
        }
    }
    
    [SOCKETLAST writeData:adata];
        
    }
}

- (void)getOpen
{
    Byte byte[] = {0x15,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0C,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    [SOCKETLAST writeData:adata];
}

- (void)createCell:(NSMutableArray*)arrWithData{
    if (arrWithData.count > 0) {
        openWithArr = arrWithData;
        Byte *singleByte = (Byte*)[[arrWithData firstObject] bytes];
        Byte nameByte[singleByte[10]];
        for (integer_t i=0; i<singleByte[10]; i++) {
            nameByte[i] = singleByte[11+i];
        }
        NSData *asdata = [[NSData alloc] initWithBytes:nameByte length:sizeof(nameByte)];
        NSString *nameStr = [public stringGB2312FromHex:asdata];
        UILabel *infoTitle = (UILabel*)[self viewWithTag:201507061];
        infoTitle.text = nameStr;
        
        UIImage *leftImage = [UIImage imageNamed:@"deng"];
        UIImageView *leftImageView = (UIImageView*)[self viewWithTag:201507062];
        leftImageView.image = leftImage;
        
        UILabel *colorLabel = (UILabel*)[self viewWithTag:201507063];
        colorLabel.text = @"颜色";
        
        CustomView *customView = (CustomView*)[self viewWithTag:201507064];
        customView.isRing = true;
        customView.color = RGB(255, 0, 0, 0.8);
        
        
        UIButton *openbtn = (UIButton*)[self viewWithTag:321];
        [openbtn addTarget:self action:@selector(setOpen:) forControlEvents:UIControlEventTouchUpInside];
        if (arrWithData.count == 2) {
            NSData *dataOpen = [arrWithData objectAtIndex:1];
            Byte *byteOpen = (Byte *)[dataOpen bytes];
            if (byteOpen[5] == 0x01) {
                [openbtn setBackgroundImage:[UIImage imageNamed:@"on_btn"] forState:UIControlStateNormal];
                isLight = 1;
            } else {
                [openbtn setBackgroundImage:[UIImage imageNamed:@"off_btn"] forState:UIControlStateNormal];
                isLight = 0;
            }
            
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

#pragma mark socketControllerDelegate
-(void)readData:(NSData *)data remoteType:(NSString *)type
{

}

-(void)socketStatus:(BOOL)status
{
    NSLog(@"login socketStatus");
}

@end
