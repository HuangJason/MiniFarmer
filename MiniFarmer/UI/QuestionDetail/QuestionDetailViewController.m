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
    self.view.backgroundColor = [UIColor whiteColor];
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
    _tableView.tableHeaderView = _commonView;
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
    [_commonView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(kStatusBarHeight+kNavigationBarHeight);
//        make.left.equalTo(self.view);
//        make.width.equalTo(self.view);
        make.top.equalTo(_tableView);
        make.left.equalTo(_tableView);
        make.width.equalTo(_tableView);
        make.height.mas_equalTo(needHeight);
    }];
    //回答列表
//    CGFloat curY = kStatusBarHeight+kNavigationBarHeight + needHeight;
//    _tableView.frame = CGRectMake(0, curY, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-curY);
    [_tableView reloadData];
}

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = repItem.replaytext;
    return cell;
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuestionAnsModel *ansItem = [_qAnsArr objectAtIndex:section];
    
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.7];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 22)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text=ansItem.hdnr;
    [myView addSubview:titleLabel];
    return myView;
}

@end
