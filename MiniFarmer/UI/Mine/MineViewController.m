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

#define kSection

@implementation UserMenuItem

@end

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *_tableView;
    NSArray  *_keysArr;
    NSMutableDictionary *_sourceDic;
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
    _sourceDic = [NSMutableDictionary dictionaryWithCapacity:1];
    _keysArr = @[@"key0",@"key1",@"key2",@"key3"];
    
    NSMutableArray *tmpArr0 = [NSMutableArray arrayWithCapacity:1];
    UserMenuItem *item1 = [UserMenuItem new];
    item1.title = @"我的回答";
    [tmpArr0 addObject:item1];
    
    UserMenuItem *item2 = [UserMenuItem new];
    item2.title = @"我的订单";
    [tmpArr0 addObject:item2];
    
    UserMenuItem *item3 = [UserMenuItem new];
    item3.title = @"我的配方";
    [tmpArr0 addObject:item3];
    [_sourceDic setObject:tmpArr0 forKey:_keysArr[0]];
    
    NSMutableArray *tmpArr1 = [NSMutableArray arrayWithCapacity:1];
    UserMenuItem *item4 = [UserMenuItem new];
    item4.title = @"我的农人币";
    item4.subTitle = @"兑换商城正式上线";
    [tmpArr1 addObject:item4];
    [_sourceDic setObject:tmpArr1 forKey:_keysArr[1]];
    
    NSMutableArray *tmpArr2 = [NSMutableArray arrayWithCapacity:1];
    UserMenuItem *item5 = [UserMenuItem new];
    item5.title = @"填写邀请码";
    [tmpArr2 addObject:item5];
    [_sourceDic setObject:tmpArr2 forKey:_keysArr[2]];
    
    NSMutableArray *tmpArr3 = [NSMutableArray arrayWithCapacity:1];
    UserMenuItem *item6 = [UserMenuItem new];
    item6.title = @"设置";
    [tmpArr3 addObject:item6];
    [_sourceDic setObject:tmpArr3 forKey:_keysArr[3]];
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
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    else{
        return 9;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.bounds), 1)];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.bounds), 1)];
    return view;
}

#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keysArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowArr = [_sourceDic objectForKey:_keysArr[section]];
    return rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"mineCenter";
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *rowArr = [_sourceDic objectForKey:_keysArr[section]];
    UserMenuItem *item = rowArr[row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.subTitle;
    
    return cell;
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
