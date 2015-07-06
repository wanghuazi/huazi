//
//  doubleTableViewCell.m
//  detapp
//
//  Created by wanghaohua on 15/6/21.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "doubleTableViewCell.h"
#import "CustomView.h"
#import "Header.h"
#import "public.h"

@implementation doubleTableViewCell

@synthesize cellData;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        doubleWithData = [NSData data];
        return self;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)createCell:(NSData*)data{
    doubleWithData = data;
    Byte *doubleByte = (Byte*)[doubleWithData bytes];
//    Byte nameByte[singleByte[10]];
//    for (integer_t i=0; i<singleByte[10]; i++) {
//        nameByte[i] = singleByte[11+i];
//    }
//    NSData *asdata = [[NSData alloc] initWithBytes:nameByte length:sizeof(nameByte)];
//    NSString *nameStr = [public stringGB2312FromHex:asdata];
    
    Byte nameByte[doubleByte[4]];
    for (integer_t i=0; i<doubleByte[4]; i++) {
        nameByte[i] = doubleByte[5+i];
    }
    NSData *asdata = [[NSData alloc] initWithBytes:nameByte length:sizeof(nameByte)];
    NSString *nameStr = [public stringGB2312FromHex:asdata];
//    NSString *nameStr = [[NSString alloc] initWithData:asdata encoding:NSUTF8StringEncoding];
    NSLog(@"doubleByte %@", nameStr);
    
//    UILabel *infoTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 17, 150, 20)];
//    infoTitle.text = nameStr;
//    [self.contentView addSubview:infoTitle];
    
    UIImage *leftImage = [UIImage imageNamed:@"bangongshi"];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 70, 70)];
    leftImageView.image = leftImage;
    [self.contentView addSubview:leftImageView];
    
    
    UILabel *colorInfo = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 150, 20)];
    colorInfo.text =nameStr;
    [self.contentView addSubview:colorInfo];

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
