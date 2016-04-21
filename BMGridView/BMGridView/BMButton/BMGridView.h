//
//  BMGridView.h
//  BMButton
//
//  Created by Bob on 16/4/20.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMButtonConst.h"

@class BMButton;

@protocol GridClickDelegate <NSObject>

- (void)gridClickAction:(BMButton*)button;

@end

@interface BMGridView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) id<GridClickDelegate> delegate;

@end
