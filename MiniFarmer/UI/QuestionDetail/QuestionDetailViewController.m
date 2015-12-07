//
//  QuestionDetailViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "QuCommonView.h"
#import "BaseViewController+Navigation.h"
#import "QuestionAnsModel.h"
#import "QuAnswerHeaderView.h"
#import "QuAnswerReplyCell.h"

@interface QuestionDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSString *curWtid;
@property (nonatomic, strong)QuCommonView *commonView;
@property (nonatomic, strong)QuestionInfo *qInfo;
@property (nonatomic, strong)NSMutableArray *qAnsArr;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation QuestionDetailViewController
- (instancetype)initWithWtid:(NSString *)wtid
{
    self = [super init];
    if (self) {
        _curWtid = wtid;
        _qAnsArr = [NSMutableArray arrayWithCapacity:1];
    }
    
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBgGrayColor;
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(backBtnPressed)];
    //[self commonInit];
    [self addSubviews];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *userId;
    if ([[MiniAppEngine shareMiniAppEngine] isLogin]) {
        userId = [[MiniAppEngine shareMiniAppEngine] userId];
    }
    else{
        userId = @"0";
    }
    [self setNavigationBarIsHidden:NO];
    [self requestQuDataWithUserId:userId wtid:_curWtid];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavigationBarIsHidden:YES];
}

#pragma mark- private
- (void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commonInit
{

}

- (void)addSubviews
{
    self.commonView = [[QuCommonView alloc] init];
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)updateViewWhenGetData
{
    //title
    NSString *title = [NSString stringWithFormat:@"%@的问题",_qInfo.xm];
    [self setBarTitle:title];
    
    //问题及回答列表
    CGFloat curY = kStatusBarHeight+kNavigationBarHeight;
    _tableView.frame = CGRectMake(0, curY, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-curY);
    //问题内容
    [_commonView refreshWithQuestionInfo:_qInfo];
    CGFloat needHeight = _commonView.totalViewHeight;
    _commonView.frame = CGRectMake(0, 0, _tableView.bounds.size.width, needHeight);
    _tableView.tableHeaderView = _commonView;

    //回答列表
//    CGFloat curY = kStatusBarHeight+kNavigationBarHeight + needHeight;
//    _tableView.frame = CGRectMake(0, curY, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-curY);
    [_tableView reloadData];
}

//- (UIView *)sectionHeader
//{
//    
//}

#pragma mark- 网络请求
- (void)requestQuDataWithUserId:(NSString *)uid wtid:(NSString *)wtid
{
    NSDictionary *dicPar =@{
//                            @"c":@"tw",
//                            @"m":@"getwthflist",
                            @"userid":[NSNumber numberWithInt:[uid intValue]],
                            @"wtid":[NSNumber numberWithInt:[wtid intValue]],
                            };
    __weak QuestionDetailViewController *wself = self;
    
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=tw&m=getwthflist"
                                         parameters:dicPar
                                     prepareExecute:nil
                                            success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if (!responseObject) {
            DLOG(@"responseObject is nil");
            return ;
        }
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResult = responseObject;
            BOOL code = [[dicResult objectForKey:@"code"] boolValue];
            NSString *msg = [dicResult objectForKey:@"msg"];
            DLOG(@"code = %d,msg = %@",code,msg);
            if (!code) {
                //显示加载错误提示
                return;
            }
            else{
                //问题详情
                NSDictionary *dicQueInfo = [dicResult objectForKey:@"wt"];
                self.qInfo = [[QuestionInfo alloc] initWithDictionary:dicQueInfo error:nil];
                
                //回答列表
                self.qAnsArr = [QuestionAnsModel arrayOfModelsFromDictionaries:[dicResult objectForKey:@"list"]];
                
                //刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [wself updateViewWhenGetData];
                });
                return;
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _qAnsArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:section];
    return ansItem.relist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:indexPath.section];
    ReplyModel *repItem = [ansItem.relist objectAtIndex:indexPath.row];
    
    static NSString *identifier = @"relistCell";
    QuAnswerReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QuAnswerReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell refreshWithReplyModel:repItem];
    
    return cell;
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:section];
    CGFloat height = [QuAnswerHeaderView headerHeightWithAnsModel:ansItem];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionAnsModel *ansItem= [_qAnsArr objectAtIndex:indexPath.section];
    ReplyModel *repItem = [ansItem.relist objectAtIndex:indexPath.row];
    CGFloat height = [QuAnswerReplyCell cellTotalHightWithReplyModel:repItem];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuestionAnsModel *ansItem = [_qAnsArr objectAtIndex:section];
    static NSString *HeaderIdentifier = @"QuHeader";
    
    QuAnswerHeaderView *myHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!myHeader) {
        myHeader = [[QuAnswerHeaderView alloc] initWithReuseIdentifier:HeaderIdentifier];
    }
    [myHeader refreshWithAnsModel:ansItem];
    return myHeader;
}

@end
