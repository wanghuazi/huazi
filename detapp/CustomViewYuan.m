//
//  CustomViewYuan.m
//  detapp
//
//  Created by wanghaohua on 15/6/10.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "CustomViewYuan.h"
#import "Header.h"


@implementation CustomViewYuan
@synthesize color;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        circleSize.width = frame.size.width;
        circleSize.height = frame.size.height;
    }
    return self;
}


// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    UIColor *aColor = RGB(255, 0, 0, 0.8);
    CGContextSetFillColorWithColor(context, self.color.CGColor);//填充颜色
    
    CGContextSetLineWidth(context, 0.0);//线的宽度
    CGContextAddArc(context, circleSize.width / 2, circleSize.height / 2, circleSize.width / 2, 0, 2*PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
}

@end
