//
//  public.h
//  detapp
//
//  Created by wanghaohua on 15/5/26.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface public : NSObject

+ (NSString *)ToHex:(uint16_t)tmpid;

//image Location
+ (UIColor*) getPixelColorAtLocation:(CGPoint)point image:(UIImage*)image;
+ (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage;
+ (NSString*)stringGB2312FromHex:(NSData*)data;

@end
