//
//  SigningView.m
//  SigningViewTest
//
//  Created by SunShine on 13-8-9.
//  Copyright (c) 2013年 csair. All rights reserved.
//

#import "SigningView.h"
#define ALL_LINES_CAPACITY 20
#define ALL_POINTS_CAPACITY 50

@implementation SigningView
@synthesize fontColor,fontSize;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.fontColor = [UIColor blackColor];
        self.fontSize = 1.0f;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //第一次绘制的时候初始化
    if (allLines == nil) {
        NSLog(@"init array!");
        allLines = [[NSMutableArray alloc] initWithCapacity:ALL_LINES_CAPACITY];
        allPoints = [[NSMutableArray alloc] initWithCapacity:ALL_POINTS_CAPACITY];
    }
    //获取上下文
	CGContextRef context=UIGraphicsGetCurrentContext();
	//设置笔冒
	CGContextSetLineCap(context, kCGLineCapRound);
	//设置画线的连接处　拐点圆滑
	CGContextSetLineJoin(context, kCGLineJoinRound);
    //绘制之前的笔画
    if ([allLines count]>0) {
        for (int i = 0; i < [allLines count]; i++) {
            NSArray* tempLine=[NSArray arrayWithArray:[allLines objectAtIndex:i]];
            [self drawPointsInArray:tempLine withContext:context];
        }
    }
    //绘制当前的笔画
    [self drawPointsInArray:allPoints withContext:context];
}

/**
 *	@brief	将数组中的点绘制到画布上
 *
 *	@param 	pointArray 	像素点的数组
 *	@param 	context 	画布
 */
-(void)drawPointsInArray:(NSArray *)pointArray withContext:(CGContextRef)context
{
    if ([pointArray count] >1) {
        CGContextBeginPath(context);
        //绘制起点
        CGPoint myStartPoint=[[pointArray objectAtIndex:0] CGPointValue];
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        //逐一绘制剩下的点
        for (int i=0; i<[pointArray count]-1; i++){
            CGPoint myEndPoint= [[pointArray objectAtIndex:i+1] CGPointValue];
            CGContextAddLineToPoint(context, myEndPoint.x, myEndPoint.y);
        }
        //画笔颜色与宽度
        CGContextSetStrokeColorWithColor(context, [self.fontColor CGColor]);
        CGContextSetFillColorWithColor (context,  [self.fontColor CGColor]);
        CGContextSetLineWidth(context, self.fontSize);
        //把数组里面的点全部画出来
        CGContextStrokePath(context);
    } else {
//        NSLog(@"当前点数%d少于两个!",[pointArray count]);
    }
}

-(void)beginDrawNewLine{
    NSLog(@"begin to draw a new line.");
//    if (allPoints && [allPoints count]>0) {
//        [allPoints removeAllObjects];
//    }
    if (![allLines containsObject:allPoints]) {
        NSLog(@"last line didn't end in right way!");
        [allPoints addObject:allPoints];
    }
    allPoints = nil;
    allPoints = [[NSMutableArray alloc] initWithCapacity:ALL_POINTS_CAPACITY];
}

-(void)endDrawNewLine{
    NSLog(@"end to draw a line.");
    [allLines addObject:allPoints];
    [self setNeedsDisplay];
}

-(void)drawingPoint:(CGPoint)sender{
    NSValue* pointvalue=[NSValue valueWithCGPoint:sender];
	[allPoints addObject:[pointvalue retain]];
//    NSLog(@"add point %@", pointvalue);
	[pointvalue release];
}

-(void)cleanLastLine{
    if (allLines && [allLines count]>0) {
        [allLines removeLastObject];
        [allPoints removeAllObjects];
    }
    [self setNeedsDisplay];
}

-(void)cleanAllLines{
    if (allLines && [allLines count]>0) {
        [allLines removeAllObjects];
        [allPoints removeAllObjects];
    }
    allLines = [[NSMutableArray alloc] initWithCapacity:ALL_LINES_CAPACITY];
    allPoints = [[NSMutableArray alloc] initWithCapacity:ALL_POINTS_CAPACITY];
    [self setNeedsDisplay];
}

-(UIImage *)imageForSigning{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, self.layer.contentsScale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
