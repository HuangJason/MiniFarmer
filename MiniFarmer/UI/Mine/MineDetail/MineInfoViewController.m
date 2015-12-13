

//
//  MineInfoViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/12.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineInfoViewController.h"

@interface MineInfoViewController ()

@property (nonatomic, strong) UITableView *infoTableView;

@end

@implementation MineInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarTitle:@"个人信息"];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - click

- (void)back:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - subviews
- (UITableView *)infoTableView
{
    if (!_infoTableView)
    {
        _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yDispaceToTop, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop) style:UITableViewStylePlain];
    }
    return _infoTableView;
}

@end
