//
//  MyResponseViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/18.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyResponseViewController.h"
#import "MineResponseTableController.h"

@interface MyResponseViewController ()

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

@implementation MyResponseViewController

- (instancetype)init
{
    if (self = [super init])
    {
        self.dataDic = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - other
- (void)addSubviews
{
    MineResponseTableController *mineVC = [[MineResponseTableController alloc] init];
    [self.view addSubview:mineVC.view];
    [self addChildViewController:mineVC];
}


#pragma mark - delegate or block


#pragma mark - events




@end
