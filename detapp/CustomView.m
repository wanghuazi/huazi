#import "CustomView.h"
#import "Header.h"

@implementation CustomView

@synthesize isRing;
@synthesize color;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画大圆并填充颜
//    UIColor*aColor = RGB(255, 0, 0, 0.8);
    CGContextSetFillColorWithColor(context, self.color.CGColor);//填充颜色
    
    if (self.isRing) {
        CGContextSetLineWidth(context, 1.0);//线的宽度
    } else {
        CGContextSetLineWidth(context, 0.0);//线的宽度
    }
    
    CGContextAddArc(context, 10,10, 8, 0, 2*PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
    
}


@end
