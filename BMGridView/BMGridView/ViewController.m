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
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()<GridClickDelegate,GridViewDataSource>

@property (nonatomic, strong) BMGridView *gridView;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initGridData];
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
        _gridView.dataSource = self;
	}
	return _gridView;
}

- (void)initGridData
{
    _titleArray = @[@"pre_order",@"cus_manager",@"shekong",@"bangdan",@"today_caiwu",@"detial_7",@"shenpi",@"detial_2",@"detial_4", @"shekong",  @"detial_9"].mutableCopy;
    _imageArray = @[@"pre_order",@"cus_manager",@"shekong",@"bangdan",@"today_caiwu",@"detial_7",@"shenpi",@"detial_2",@"detial_4", @"shekong",  @"detial_9"].mutableCopy;
}

#pragma mark- GridClickDelegate
- (void)gridClickAction:(BMButton *)button
{
    NSInteger position = button.position;
    switch (position) {
        case 0:
        {
            NSLog(@"action %@",button);
            TestViewController *viewController = [TestViewController new];
            viewController.title = button.title;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"action %@",button);
            SecondViewController *viewController = [SecondViewController new];
            viewController.title = button.title;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"action %@",button);
            ThirdViewController *viewController = [ThirdViewController new];
            viewController.title = button.title;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
        {
            NSLog(@"action %@",button);
            TestViewController *viewController = [TestViewController new];
            viewController.title = button.title;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
    }
}

#pragma mark- GridView DataSource
- (NSInteger)numberOfPositionsInGridView:(BMGridView *)BMGridView
{
    return _titleArray.count;
}

- (NSString *)gridView:(BMGridView *)tableView titleNameInPosition:(NSInteger)position
{
    return _titleArray[position];
}

- (NSString *)gridView:(BMGridView *)tableView iconNameInPosition:(NSInteger)position
{
    return _imageArray[position];
}

@end
