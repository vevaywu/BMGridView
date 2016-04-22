//
//  BMButton.m
//  BMButton
//
//  Created by Bob on 16/4/20.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "BMButton.h"
#import "BMButtonConst.h"

@interface BMButton()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSDate *startTime;

@property (nonatomic, strong) UIButton *delButton;

@property (nonatomic, assign) BOOL draging;

@property (nonatomic, assign) CGRect orignRect;

@property (nonatomic, assign) CGRect newRect;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) id delegate;

@property (nonatomic, assign, nonnull) SEL selector;

@end

@implementation BMButton

#pragma mark- Life Cycle Method
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubView];
        [self initParams];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        [self initParams];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubView];
        [self initParams];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        [self initSubView];
        [self initParams];
        _title = title;
        self.titleLabel.text = title;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title withImage:(UIImage*)image
{
    self = [super init];
    if (self) {
        [self initSubView];
        [self initParams];
        _title = title;
        _image = image;
        self.titleLabel.text = title;
    }
    return self;
}

- (void)initSubView
{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

- (void)initParams
{
    _minimumPressDuration = 0.5f;
    _newRect = CGRectZero;
}

#pragma mark- Init SubView
- (UILabel *)titleLabel {
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleLabel;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    self.titleLabel.center = CGPointMake(ButtonWidth /2, ButtonHeight * 0.67);
}

- (UIImageView *)imageView {
    if(_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, 22.5, 22.5);
        _imageView.center = CGPointMake(ButtonWidth /2, ButtonHeight /3);
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
    self.imageView.center = CGPointMake(ButtonWidth /2, ButtonHeight /3);
    self.title = _title;
}

- (void)setPosition:(NSInteger)position
{
    _position = position;
    self.tag = position;
}

#pragma mark- Adjusts Width
- (void)setAdjustsButtonSizeToFitWidth:(BOOL)adjustsButtonSizeToFitWidth
{
    UIView *superView = self.superview;
    if (!superView) return;
    
    _adjustsButtonSizeToFitWidth = adjustsButtonSizeToFitWidth;
    
    CGRect superFrame = superView.frame;
    CGRect frame = self.frame;
    
    frame.size.width = superFrame.size.width / GridCol;
    frame.size.height = frame.size.width;
    
    frame.origin.x = (superView.subviews.count- 1)%4 *frame.size.width;
    frame.origin.y = ((superView.subviews.count -1)/4) *frame.size.width;
    
    self.frame = frame;
    
    frame = _titleLabel.frame;
    frame.size.width = superFrame.size.width/4;
    frame.size.height = frame.size.width * 0.33;
    _titleLabel.frame = frame;
}

#pragma mark- Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _startTime = [NSDate date];
    _orignRect = self.frame;
    _newRect = CGRectZero;
    self.transform = CGAffineTransformIdentity;
    self.backgroundColor = BG_COLOR;
    [self createLongPressTimer];
    UIView *superView = self.superview;
    for (BMButton *button in superView.subviews) {
        if (button != self) {
            button.editing = NO;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (-[_startTime timeIntervalSinceNow] > _minimumPressDuration && !_editing) {
        self.editing = YES;
    }
    
    if (_draging) {
        CGPoint point = [(UITouch *)[touches anyObject] locationInView : self.superview];
        self.center = point;
        
        [self handleDraging];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.transform = CGAffineTransformIdentity;
    [self releaseTimer];
    if (-[_startTime timeIntervalSinceNow] > _minimumPressDuration && !_editing) {
        self.editing = YES;
    }
    
    if (!_editing) {
      self.backgroundColor = [UIColor clearColor];
    }
    if (_draging) {
        if (CGRectEqualToRect(_newRect, CGRectZero) ) {
            self.frame = _orignRect;
        }else{
            self.frame = _newRect;
            self.editing = NO;
        }
        _draging = NO;
    }else{
        [self execButtonClick:self];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_editing) {
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark- Handle Event
- (void)setEditing:(BOOL)editing
{
    _editing = editing;
    if (!editing) {
        self.backgroundColor = [UIColor clearColor];
        [self.delButton removeFromSuperview];
    }else{
        self.backgroundColor = BG_COLOR;
        [self addSubview:self.delButton];
        self.transform = CGAffineTransformScale(self.transform,1.2, 1.2);
        [self.superview bringSubviewToFront:self];
        self.draging = YES;
    }
}

- (void)handleDraging
{
    NSInteger startPostion = -1;
    for (BMButton *button in self.superview.subviews) {
        if (CGRectContainsPoint(button.frame, self.center) && button != self) {
            startPostion = button.tag;
            _newRect = button.frame;
            break;
        }
    }
    
    __block CGRect frame = _orignRect;
    __block CGRect orignFrame = CGRectZero;
    NSInteger endPostion = self.tag;
    if (startPostion == -1) return;
    if (endPostion > startPostion) {
        for (NSInteger i = endPostion-1; i>= startPostion; i--) {
            BMButton *button = nil;
            for (BMButton *object in self.superview.subviews) {
                if (object.tag == i) {
                    button = object;
                }
            }
            orignFrame = button.frame;
            [UIView animateWithDuration:0.5f animations:^{
                button.frame = frame;
                frame = orignFrame;
                button.tag = i+1;
            }];
        }
        self.tag = startPostion;
        _orignRect = CGRectMake((self.tag%4) * (ButtonWidth), (self.tag/4)*(ButtonHeight), (ButtonWidth), (ButtonHeight));
    }
    
    if (startPostion > endPostion) {
        for (NSInteger i = endPostion+1; i<= startPostion; i++) {
            BMButton *button = nil;
            for (BMButton *object in self.superview.subviews) {
                if (object.tag == i) {
                    button = object;
                }
            }
            orignFrame = button.frame;
            [UIView animateWithDuration:0.5f animations:^{
                button.frame = frame;
                frame = orignFrame;
                button.tag = i-1;
            }];
        }
        self.tag = startPostion;
        _orignRect = CGRectMake((self.tag%4) * (ButtonWidth), (self.tag/4)*(ButtonHeight), (ButtonWidth), (ButtonHeight));
    }
}

- (UIButton *)delButton {
	if(_delButton == nil) {
		_delButton = [[UIButton alloc] init];
        CGRect frame = self.frame;
        _delButton.frame = CGRectMake(frame.size.width - 26, 10, 16, 16);
        [_delButton setBackgroundImage:[UIImage imageNamed:@"delete_image"] forState:UIControlStateNormal];
        [_delButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _delButton;
}

- (void)deleteButtonAction:(UIButton *)sender
{
    self.hidden = YES;
    __block CGPoint point = self.center;
    __block CGPoint orignPoint = CGPointZero;
    NSInteger index = self.tag;
    NSInteger count = self.superview.subviews.count;
    for (NSInteger i = index+1; i< count; i++) {
        BMButton *button = nil;
        for (BMButton *object in self.superview.subviews) {
            if (object.tag == i) {
                button = object;
            }
        }
        orignPoint = button.center;
        [UIView animateWithDuration:0.5f animations:^{
            button.center = point;
            point = orignPoint;
            button.tag = i-1;
        }];
    }
    
    [self removeFromSuperview];
}

-(void)createLongPressTimer
{
    if (_timer) [self releaseTimer];
    
    _timer = [NSTimer timerWithTimeInterval:0.1f target:self selector:@selector(updateLongPresss) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)releaseTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)updateLongPresss
{
    if (-[_startTime timeIntervalSinceNow] > _minimumPressDuration && !_editing) {
        self.editing = YES;
    }
}

#pragma mark- Click Event
- (void)addTarget:(id)target action:(SEL)action
{
    _delegate = target;
    _selector = action;
}

- (void)execButtonClick:(BMButton*)sender
{
    if (_delegate && [_delegate respondsToSelector:_selector]) {
        SuppressPerformSelectorLeakWarning(
            [self.delegate performSelector:self.selector withObject:sender];
        );
    }
}

@end
