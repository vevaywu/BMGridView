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

@property (nonatomic, assign) CGFloat minimumPressDuration;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithTitle:(NSString*)title;

- (void)addTarget:(id)target action:(SEL)action;

@end
