//
//  HomeViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "HomeViewController.h"
#import "QuestionInfo.h"
#import "SimpleImageTitleButton.h"
#import "QuestionCell.h"

#define kPageSize   @"10"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_sourceArr;
    NSUInteger      _totalQuestionCount;
    UIView          *_headView;
}

@property (nonatomic , strong) UITableView *homeTableView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self commonInit];
    [self addSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self requestHomeData];
}

#pragma mark- private
- (void)commonInit
{
    _sourceArr = [NSMutableArray arrayWithCapacity:1];
    
}

- (void)addSubviews
{
    [self headViewInit];
    _homeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _homeTableView.dataSource = self;
    _homeTableView.delegate = self;
    _homeTableView.tableHeaderView = _headView;
    [self.view addSubview:_homeTableView];
}

- (void)headViewInit
{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 270)];
    _headView.backgroundColor = [UIColor yellowColor];
    UIImageView *hImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_headView.bounds), 170)];
    [_headView addSubview:hImage];
    UIView *funView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(hImage.bounds), CGRectGetWidth(_headView.bounds), 100)];
    [_headView addSubview:funView];
    
    //
    SimpleImageTitleButton *buyBtn = [self buttonWithNormalName:@"home_btn_buy_nm" andSelectName:nil andTitle:@"买农药"];
    [funView addSubview:buyBtn];
//    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(funView).offset(14);
//        make.left.equalTo(funView).offset(30);
//        make.size.mas_equalTo(CGSizeMake(70, 86));
//    }];
//    [buyBtn setTopImageSize:CGSizeMake(51, 51) imageTopHeight:0 titleBottomHeight:0];
}

//创建一个按钮
- (SimpleImageTitleButton *)buttonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title
{
    CGFloat buttonW = 70;
    CGFloat buttonH = 86;
    
    SimpleImageTitleButton *button = [SimpleImageTitleButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    button.frame = CGRectMake(0, 0, buttonW, buttonH);
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:selected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    //[button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
 
    button.titleLabel.font = [UIFont systemFontOfSize:14]; // 设置标题的字体大小
    [button setTitleColor:RGBCOLOR(61, 61, 61) forState:UIControlStateNormal];
    
//    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height+6,-button.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [button setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -button.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不变
    [button setTopImageSize:CGSizeMake(51, 51) imageTopHeight:0 titleBottomHeight:0];
    return button;
}

- (void)requestHomeData
{
    NSDictionary *dicPar =@{
                            @"c":@"tw",
                            @"m":@"gettwlist",
                            @"id":@"0",
                            @"pagesize":kPageSize,
                            };
    __weak HomeViewController *wself = self;
    
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
                NSMutableArray *curQuestions = [QuestionInfo arrayOfModelsFromDictionaries:[dicResult objectForKey:@"list"]];
                for (int i =0; i<curQuestions.count; i++) {
                    QuestionInfo *info = [curQuestions objectAtIndex:i];
                    QuestionCellSource *item = [[QuestionCellSource alloc] initWithQuestionInfo:info];
                    [_sourceArr addObject:item];
                }
                
                [wself.homeTableView reloadData];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indetfy = @"homecell";
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:indetfy];
    if (!cell) {
        cell = [[QuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetfy];
    }
    
    [cell refreshWithQuestionCellSource:(QuestionCellSource *)_sourceArr[indexPath.row]];
    
    return cell;
}


@end
