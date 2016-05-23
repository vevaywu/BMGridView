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

@class BMGridView;

@protocol GridClickDelegate <NSObject>

- (void)gridClickAction:(BMButton*)button;

@end

@protocol GridViewDataSource <NSObject>

- (NSString*)gridView:(BMGridView *)tableView titleNameInPosition:(NSInteger)position;

- (NSString*)gridView:(BMGridView *)tableView iconNameInPosition:(NSInteger)position;

- (NSInteger)numberOfPositionsInGridView:(BMGridView *)BMGridView;

- (BOOL)gridView:(BMGridView *)tableView hideRedDotInPosition:(NSInteger)position;

@end

@interface BMGridView : UIView

@property (nonatomic, weak, nullable) id<GridClickDelegate> delegate;

@property (nonatomic, weak, nullable) id<GridViewDataSource> dataSource;

@end
