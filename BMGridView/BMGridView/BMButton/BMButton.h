//
//  BMButton.h
//  BMButton
//
//  Created by Bob on 16/4/20.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMButton : UIView

@property (nonatomic, assign) BOOL adjustsButtonSizeToFitWidth;

@property (nonatomic, assign) BOOL editing;

@property (nonatomic, assign) BOOL hideRedDot;

@property (nonatomic, assign) CGFloat minimumPressDuration;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger position;

- (instancetype)initWithTitle:(NSString*)title;

- (void)addTarget:(id)target action:(SEL)action;

@end
