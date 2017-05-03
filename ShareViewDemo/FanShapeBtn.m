//
//  FanShapeBtn.m
//  ShareViewDemo
//
//  Created by 王恒求 on 2016/4/27.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "FanShapeBtn.h"

@implementation FanShapeBtn

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx, rect);
    [[UIColor redColor] set];
    CGContextFillPath(ctx);
    
    CGContextSetLineWidth(ctx, 5);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(rect.size.width/2, 16)];
    [path2 addLineToPoint:CGPointMake(rect.size.width/2, rect.size.height-16)];
    CGContextAddPath(ctx, path2.CGPath);
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(16, rect.size.height/2)];
    [path3 addLineToPoint:CGPointMake(rect.size.width-16, rect.size.height/2)];
    CGContextAddPath(ctx, path3.CGPath);
    
    CGContextStrokePath(ctx);
}

@end
