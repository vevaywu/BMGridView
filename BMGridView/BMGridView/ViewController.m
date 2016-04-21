//
//  ViewController.m
//  BMButton
//
//  Created by Bob on 16/4/20.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "ViewController.h"
#import "BMGridView.h"
#import "BMButton.h"
#import "TestViewController.h"

@interface ViewController ()<GridClickDelegate>

@property (nonatomic, strong) BMGridView *gridView;

@property (nonatomic, strong) NSMutableArray *gridDataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initGridData];
    
    [self.gridView setDataArray:self.gridDataArray];
    [self.view addSubview:self.gridView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BMGridView *)gridView {
	if(_gridView == nil) {
		_gridView = [[BMGridView alloc] init];
        _gridView.frame = CGRectMake(0, 100, screen_width, screen_height - 164);
        _gridView.backgroundColor = [UIColor whiteColor];
        _gridView.delegate = self;
	}
	return _gridView;
}

- (NSMutableArray *)gridDataArray {
	if(_gridDataArray == nil) {
		_gridDataArray = [[NSMutableArray alloc] init];
	}
	return _gridDataArray;
}

- (void)initGridData
{
    //初始化数据
    for (int i=0; i<12; i++) {
        NSString *item  = [NSString stringWithFormat:@"item%d",i+1];
        [self.gridDataArray addObject:item];
    }
}

#pragma mark- GridClickDelegate
- (void)gridClickAction:(BMButton *)button
{
    NSLog(@"action %@",button);
    TestViewController *viewController = [TestViewController new];
    viewController.title = button.title;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
