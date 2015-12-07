//
//  MineViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "InvitedCodeViewController.h"
#import "SettingViewController.h"
#import "MyResponseViewController.h"
#import "MineRecipeViewController.h"
#import "HeaderLoginView.h"
#import "HeaderNotLoginView.h"
#import "MineCell.h"
#import "MineNothingCell.h"
#import "MineSegmentCell.h"
#import "UserMenuItem.h"

#define kSection


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *_tableView;
    NSArray  *_keysArr;
    NSMutableDictionary *_sourceDic;
    NSMutableArray *sourceArray;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self commonInit];
    [self initSubviews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)commonInit
{
    sourceArray = [[NSMutableArray alloc] init];
    UserMenuItem *item1 = [UserMenuItem new];
    item1.type = TypeSegment;
    [sourceArray addObject:item1];
    
    UserMenuItem *item2 = [UserMenuItem new];
    item2.type = TypeNothing;
    [sourceArray addObject:item2];

    UserMenuItem *item3 = [UserMenuItem new];
    item3.type = TypeOther;
    item3.imageString = @"mine_response_btn_nm";
    item3.title = @"我的回答";
    [sourceArray addObject:item3];
    
    UserMenuItem *item4 = [UserMenuItem new];
    item4.type = TypeOther;
    item4.title = @"我的订单";
    item4.imageString = @"my_money";
    [sourceArray addObject:item4];
    
    UserMenuItem *item5 = [UserMenuItem new];
    item5.type = TypeOther;
    item5.title = @"我的配方";
    item5.imageString = @"my_orderform";
    [sourceArray addObject:item5];
    
    UserMenuItem *item6 = [UserMenuItem new];
    item6.type = TypeNothing;
    [sourceArray addObject:item6];

    
    UserMenuItem *item7 = [UserMenuItem new];
    item7.type = TypeOther;
    item7.title = @"我的农人币";
    item7.imageString = @"my_recipe";
    [sourceArray addObject:item7];
    
    UserMenuItem *item8 = [UserMenuItem new];
    item8.type = TypeNothing;
    
    [sourceArray addObject:item8];

    UserMenuItem *item9 = [UserMenuItem new];
    item9.type = TypeOther;
    item9.title = @"填写邀请码";
    item9.imageString = @"invite_code";
    [sourceArray addObject:item9];

    UserMenuItem *item10 = [UserMenuItem new];
    item10.type = TypeNothing;
    
    [sourceArray addObject:item10];


    UserMenuItem *item11 = [UserMenuItem new];
    item11.type = TypeOther;
    item11.title = @"设置";
    item11.imageString = @"setting";
    [sourceArray addObject:item11];

    
    
}

- (void)initSubviews
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MineBaseTableViewCell cellHeightWihtModel:nil];
}


#pragma mark- UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserMenuItem *item = [sourceArray objectAtIndex:indexPath.row];
    if (item.type == TypeNothing)
    {
        MineNothingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nothingCell"];
        if (!cell)
        {
            cell = [[MineNothingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nothingCell"];
        }
        [cell refreshDataWithModel:item];
        return cell;
    }
    else if (item.type == TypeOther)
    {
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
        if (!cell)
        {
            cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineCell"];
        }
        [cell refreshDataWithModel:item];
        return cell;
    }
    else
    {
        MineSegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineSegmentCell"];
        if (!cell)
        {
            cell = [[MineSegmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineSegmentCell"];
        }
        [cell refreshDataWithModel:item];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // DLOG(@"secelected section is row is %d %d",indexPath.section,indexPath.row);
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row == 0) {
                MyResponseViewController *myVC = [[MyResponseViewController alloc] init];
                [self.navigationController pushViewController:myVC animated:YES];
            }
            else if (indexPath.row == 2)
            {
                MineRecipeViewController *myVC = [[MineRecipeViewController alloc] init];
                [self.navigationController pushViewController:myVC animated:YES];
            }

        }
            break;
        case 2:
        {
            InvitedCodeViewController *invitedVC = [[InvitedCodeViewController alloc] init];
            [self.navigationController pushViewController:invitedVC animated:YES];
        }
            break;
        case 3:
        {
            SettingViewController *setVC = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:setVC animated:YES];

        }
            break;
            
        default:
            break;
    }
}

@end
