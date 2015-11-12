//
//  QuestionDetailViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuestionDetailViewController.h"

@interface QuestionDetailViewController()

@property (nonatomic, strong)NSString *wtUid;
@property (nonatomic, strong)NSString *curWtid;
@end

@implementation QuestionDetailViewController
- (instancetype)initWithUid:(NSString *)uid wtid:(NSString *)wtid
{
    self = [super init];
    if (self) {
        _wtUid = uid;
        _curWtid = wtid;
    }
    
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    [self commonInit];
    [self addSubviews];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestQuDataWithUserId:_wtUid wtid:_curWtid];
}

#pragma mark- private
- (void)commonInit
{

}

- (void)addSubviews
{

}

- (void)requestQuDataWithUserId:(NSString *)uid wtid:(NSString *)wtid
{
    NSDictionary *dicPar =@{
                            @"c":@"tw",
                            @"m":@"getwthflist",
                            @"useid":[NSNumber numberWithLongLong:[uid longLongValue]],
                            @"wtid":[NSNumber numberWithLongLong:[wtid longLongValue]],
                            };
    //__weak QuestionDetailViewController *wself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet parameters:dicPar prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
                //加载数据成功
//                NSMutableArray *curQuestions = [QuestionInfo arrayOfModelsFromDictionaries:[dicResult objectForKey:@"list"]];
//                //如果是刷新数据
//                if ([lastId isEqualToString:@"0"]) {
//                    [_sourceArr removeAllObjects];
//                }
//                
//                for (int i =0; i<curQuestions.count; i++) {
//                    QuestionInfo *info = [curQuestions objectAtIndex:i];
//                    QuestionCellSource *item = [[QuestionCellSource alloc] initWithQuestionInfo:info];
//                    [_sourceArr addObject:item];
//                }
//                
//                [wself.homeTableView reloadData];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

@end
