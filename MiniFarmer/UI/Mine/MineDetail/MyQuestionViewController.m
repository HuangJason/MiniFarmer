//
//  MyQuestionViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/21.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyQuestionViewController.h"



@interface MyQuestionViewController ()

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) UITableView *questionTab;


@end

@implementation MyQuestionViewController

- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)reloadData
{
    
    if (!_dataSourceArr)
    {
        [self requestDataWithLastId:@"0"];
    }
    
}

#pragma mark - other

- (void)requestDataWithLastId:(NSString *)lastId
{
    //添加loading
    
    NSDictionary *dic = @{@"userid":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userId]],@"id":lastId,@"pagesize":kPageSize,@"mobile":[[MiniAppEngine shareMiniAppEngine] userLoginNumber]};
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:@"c=tw&m=gettw4userid" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleSuccess:responseObject lastId:lastId];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self handleFailure];
    }];
}

- (void)handleSuccess:(id)responseObject lastId:(NSString *)lastId
{
    //如果是0代表刷新 那么如果请求到了数据就要清楚现在的数据
//    MyReponseModel *model = [[MyReponseModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
//    if (!self.dataSourceArr)
//    {
//        self.dataSourceArr = [NSMutableArray arrayWithArray:model.list];
//    }
//    if (model.list.count)
//    {
//        if (!lastId.intValue)
//        {
//            [self.dataSourceArr removeAllObjects];
//        }
//        [self.dataSourceArr addObjectsFromArray:model.list];
//    }
//    [self noMoreData:model.list.count < kPageSize.intValue];
//    if (!self.dataSourceArr.count)
//    {
//        //这里显示无结果页
//        [self.view showWeakPromptViewWithMessage:@"没有内容哦"];
//    }
}

- (void)handleFailure
{
    [self.view showWeakPromptViewWithMessage:@"加载失败"];
}

- (void)loadMoreData
{
//    [self requestDataWithLastId:[self lastMyReponseModel].listId];
}

- (void)pullToRefresh
{
    [self requestDataWithLastId:@"0"];
    
}

//- (List *)lastMyReponseModel
//{
//    return [_dataSourceArr lastObject];
//}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    List *model = [_dataSourceArr objectAtIndex:indexPath.row];
//    if (model.images.count)
//    {
//        return [MineResponseImagesCell cellHeightWihtModel:model];
//    }
//    return [MineReponseCell cellHeightWihtModel:model];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    List *model = [_dataSourceArr objectAtIndex:indexPath.row];
//    MineBaseTableViewCell *cell;
//    if (model.images.count)
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"MineResponseImagesCell"];
//        if (!cell)
//        {
//            cell = [[MineResponseImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineResponseImagesCell"];
//        }
//    }
//    else
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"MineResponseCell"];
//        if (!cell)
//        {
//            cell = [[MineResponseImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineResponseCell"];
//        }
//    }
//    [cell refreshDataWithModel:model];
    return nil;
}

@end
