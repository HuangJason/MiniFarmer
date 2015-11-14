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

@interface QuestionDetailViewController()

@property (nonatomic, strong)NSString *curWtid;
@property (nonatomic, strong)QuCommonView *commonView;
@property (nonatomic, strong)QuestionInfo *qInfo;
@end

@implementation QuestionDetailViewController
- (instancetype)initWithWtid:(NSString *)wtid
{
    self = [super init];
    if (self) {
        _curWtid = wtid;
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
    [self.view addSubview:_commonView];
}

- (void)updateViewWhenGetData
{
    //title
    NSString *title = [NSString stringWithFormat:@"%@的问题",_qInfo.xm];
    [self setBarTitle:title];
    //问题内容
    [_commonView refreshWithQuestionInfo:_qInfo];
    [_commonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight+kNavigationBarHeight);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    [wself updateViewWhenGetData];
                });
                return;
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

@end
