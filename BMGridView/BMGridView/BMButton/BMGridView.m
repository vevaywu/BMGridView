//
//  BMGridView.m
//  BMButton
//
//  Created by Bob on 16/4/20.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "BMGridView.h"
#import "BMButton.h"

@interface BMGridView()

@end

@implementation BMGridView

- (void)setDelegate:(id<GridClickDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setDataSource:(id<GridViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self initButton];
}

- (void)initButton
{
    for (int index = 0; index< [_dataSource numberOfPositionsInGridView:self]; index++) {
        BMButton *button = [[BMButton alloc]initWithTitle:[_dataSource gridView:self titleNameInPosition:index]];
        button.position = index;
        [self addSubview:button];
        button.adjustsButtonSizeToFitWidth = YES;
        button.image = [UIImage imageNamed:[_dataSource gridView:self iconNameInPosition:index]];
        [button addTarget:self action:@selector(buttonClickAction:)];
        [button setHideRedDot:[_dataSource gridView:self hideRedDotInPosition:index]];
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
