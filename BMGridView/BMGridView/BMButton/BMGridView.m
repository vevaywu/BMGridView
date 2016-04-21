//
//  BMGridView.m
//  BMButton
//
//  Created by Bob on 16/4/20.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "BMGridView.h"
#import "BMButton.h"

@implementation BMGridView

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    int i = 0;
    for (NSString *item in dataArray) {
        BMButton *button = [[BMButton alloc]initWithTitle:item];
        button.tag = i++;
        [self addSubview:button];
        button.adjustsButtonSizeToFitWidth = YES;
        NSInteger index = arc4random()%3;
        button.image = [NSString stringWithFormat:@"icon%ld",(long)index];
        [button addTarget:self action:@selector(buttonClickAction:)];
    }
}

- (void)buttonClickAction:(BMButton*)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(gridClickAction:)]) {
        [_delegate gridClickAction:sender];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context,kCGLineCapSquare);
    CGContextSetLineWidth(context,1);
    CGContextSetRGBStrokeColor(context,239/255.0, 239/255.0, 244/255.0, 1.0);
    
    CGContextBeginPath(context);
    
    for (int i = 0; i< GridCol; i++) {
        CGContextMoveToPoint(context, 0, i * (ButtonWidth));
        CGContextAddLineToPoint(context,(screen_width) , i * (ButtonWidth));
        
        CGContextMoveToPoint(context, i * (ButtonWidth), 0);
        CGContextAddLineToPoint(context,i * (ButtonWidth), (GridCol -1) * (ButtonWidth));
    }
    
    CGContextStrokePath(context);
}

@end
