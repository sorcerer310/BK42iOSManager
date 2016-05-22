//
// Created by chong feng on 16/5/21.
// Copyright (c) 2016 chong feng. All rights reserved.
//

#import "UITextImage.h"


@implementation UITextImage


- (void)drawInRect:(CGRect)rect {
    [super drawInRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context,0.7,0.7,0.7,1.0);              //设置填充颜色
    UIFont *font = [UIFont boldSystemFontOfSize:15.0];              //设置字体
    [@"test" drawInRect:CGRectMake(0,0,30,30) withAttributes:font];

    NSLog(@"textimage drawInRect");
}
@end