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
        UILabel *colorInfo = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 150, 20)];
        colorInfo.tag = 232323;
        [self.contentView addSubview:colorInfo];
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 70, 70)];
        leftImageView.tag = 232322;
        [self.contentView addSubview:leftImageView];
        return self;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)createCell:(NSData*)data andRow:(NSInteger)index{
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
    
    UIImage *leftImage = [UIImage imageNamed:@"bangongshi"];
    UIImageView *groupImageView = (UIImageView*)[self viewWithTag:232322];
    groupImageView.image = leftImage;
    
    UILabel *groupLabel = (UILabel*)[self viewWithTag:232323];
    groupLabel.text =nameStr;
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
