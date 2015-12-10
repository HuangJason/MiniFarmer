//
//  MIneExpertViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MIneExpertViewController.h"
#import "MineFoucsExpertCell.h"

@interface MIneExpertViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MIneExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.tableView];
    
    [self requestInfoWithLastId:@"0"];
}

//- (UITableView *)tableView
//{
//    if (!_tableView)
//    {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//    }
//    return _tableView;
//}

- (void)requestInfoWithLastId:(NSString *)lastId
{
    //添加loading
    [self.view showLoadingWihtText:@"加载中..."];
    NSString *userId = [[MiniAppEngine shareMiniAppEngine] userId];
    NSDictionary *dic = @{@"userid":[APPHelper safeString:userId]};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet
                                             subUrl:@"?c=user&m=get_mygzzj_list"
                                         parameters:dic
                                     prepareExecute:nil
                                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                                //解析数据
                                                [self.view dismissLoading];
                                                [self cancelCurrentLoadAnimation];
                                                [self handleSucessWithResult:lastId lastId:responseObject];
                                                
                                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                [self.view dismissLoading];
                                                [self cancelCurrentLoadAnimation];

                                                [self handleFailure];
                                            }];
}


- (void)handleSucessWithResult:(id)responseObject lastId:(NSString *)lastId
{
    MineExpertModel *model = [[MineExpertModel alloc] initWithDictionary:responseObject error:nil];
    if (!self.dataSource)
    {
        self.dataSource = [NSMutableArray array];
    }
    if (!lastId && model.list.count)
    {
        [self.dataSource removeAllObjects];
    }
    [self.dataSource addObjectsFromArray:model.list];
    [self noMoreData:model.list.count < kPageSize.intValue];
    [super reloadData];
    if (!self.dataSource.count)
    {
        //这里显示无结果页
        [self.view showWeakPromptViewWithMessage:@"没有内容哦"];
    }
}

- (void)handleFailure
{
    [self.view showWeakPromptViewWithMessage:@"加载失败"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (MineFoucsExpertCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"reuseCell";
    MineFoucsExpertCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[MineFoucsExpertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - 加载和刷新

- (void)loadMoreData
{
    MineExpertList *lastModel = [self.dataSource lastObject];
    [self requestInfoWithLastId:lastModel.listId];
}

- (void)pullToRefresh
{
    [self requestInfoWithLastId:@"0"];
}


@end
