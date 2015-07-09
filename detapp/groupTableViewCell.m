//
//  sigleCellTableViewCell.m
//  detapp
//
//  Created by wanghaohua on 15/5/20.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "groupTableViewCell.h"
#import "CustomView.h"
#import "Header.h"
#import "public.h"

@implementation groupTableViewCell
@synthesize cellData;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        openWithArr = [NSMutableArray array];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 150, 20)];
        title.tag = 201507061;
        [self.contentView addSubview:title];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7, 70, 70)];
        imageView.tag = 201507062;
        [self.contentView addSubview:imageView];
        
        UIButton *openControl = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH-50, 20, 30, 30)];
        [openControl setTag:321];
        [self.contentView addSubview:openControl];
        
        return self;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}



//- (void)getOpen
//{
//    Byte byte[] = {0x15,0x00,SOCKETLAST.sn4,SOCKETLAST.sn3,SOCKETLAST.sn2,SOCKETLAST.sn1,0xFE,0x82,0x0C,0x02,0xf3,0x55,0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x00,0x00};
//    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
//    [SOCKETLAST writeData:adata];
//}

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
        
        UIImage *leftImage = [UIImage imageNamed:@"bangongshi"];
        UIImageView *leftImageView = (UIImageView*)[self viewWithTag:201507062];
        leftImageView.image = leftImage;
        
        UIButton *openbtn = (UIButton*)[self viewWithTag:321];
        [openbtn addTarget:self action:@selector(setSelect) forControlEvents:UIControlEventTouchUpInside];
        [openbtn setBackgroundImage:[UIImage imageNamed:@"add_on"] forState:UIControlStateNormal];
    }
    
}

- (void)setSelect
{
    
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
