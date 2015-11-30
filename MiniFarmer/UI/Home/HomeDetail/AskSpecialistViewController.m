//
//  AskSpecialistViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskSpecialistViewController.h"
#import "BaseViewController+Navigation.h"
#import "AskSpeicalistTableViewCell.h"

@interface AskSpecialistViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *specialistTypeBT;
@property (nonatomic, strong) UIButton *intelligentSortingBT;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UITableView *askSpeicalistTab;
@property (nonatomic, strong) NSMutableArray *askSpeicalistDataSource;

@end

@implementation AskSpecialistViewController


#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back:)];
    [self initsubviews];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - clickevent
- (void)back:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 添加子视图 以及添加约束方法
- (void)initsubviews
{
    [self.view addSubview:self.specialistTypeBT];
    [self.view addSubview:self.intelligentSortingBT];
    [self.view addSubview:self.line];
    
    [self.specialistTypeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(38);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + kNavigationBarHeigth + 11 + kLineWidth);
        make.size.mas_equalTo(CGSizeMake(95, 21));
    }];
    
    [self.intelligentSortingBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.specialistTypeBT.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(95, 21));
        make.right.equalTo(self.view.mas_right).offset(-38);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(kLineWidth));
        make.top.equalTo(self.specialistTypeBT.mas_bottom).offset(11);
    }];
}

#pragma mark - 初始化方法
- (UIButton *)specialistTypeBT
{
    if (!_specialistTypeBT)
    {
        _specialistTypeBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_specialistTypeBT setTitle:@"专家类型" forState:UIControlStateNormal];
        [_specialistTypeBT setBackgroundColor:[UIColor redColor]];
        [_specialistTypeBT setImage:[UIImage imageNamed:@"ask_speicalist_type_btn"]forState:UIControlStateNormal];
        [_specialistTypeBT setBTFont:kTextFont(16)];
        [_specialistTypeBT setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        [_specialistTypeBT setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6)];
        
        [_specialistTypeBT setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    }
    return _specialistTypeBT;
}

- (UIButton *)intelligentSortingBT
{
    if (!_intelligentSortingBT)
    {
        _intelligentSortingBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_intelligentSortingBT setBTFont:kTextFont(16)];
        [_intelligentSortingBT setTitle:@"智能排序" forState:UIControlStateNormal];
        [_intelligentSortingBT setImage:[UIImage imageNamed:@"ask_speicalist_sort_btn"]forState:UIControlStateNormal];
        [_intelligentSortingBT setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        [_intelligentSortingBT setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6)];
        [_intelligentSortingBT setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    }
    return _intelligentSortingBT;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    return _line;
}

- (UITableView *)askSpeicalistTab
{
    if (!_askSpeicalistTab)
    {
        _askSpeicalistTab = [[UITableView alloc] initWithFrame:CGRectZero];
        [_askSpeicalistTab setBackgroundColor:[UIColor whiteColor]];
        _askSpeicalistTab.delegate = self;
        _askSpeicalistTab.dataSource = self;
        _askSpeicalistTab.scrollsToTop = YES;
        _askSpeicalistTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _askSpeicalistTab;
}

#pragma mark - tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.askSpeicalistDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AskSpeicalistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AskSpeicalistTableViewCell"];
    if (!cell)
    {
        cell = [[AskSpeicalistTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AskSpeicalistTableViewCell"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AskSpeicalistTableViewCell cellHeightWihtModel:nil];
}

@end
