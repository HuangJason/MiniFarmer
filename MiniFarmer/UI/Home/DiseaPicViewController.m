//
//  DiseaPicViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DiseaPicViewController.h"
#import "BaseViewController+Navigation.h"
#import "StudydetailCell.h"
#import "TwoclassMode.h"
#import "UIView+FrameCategory.h"
#import "UserInfo.h"
#import "SeachView.h"


@interface DiseaPicViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation DiseaPicViewController{

    NSString *identify;
    SeachView *_seachView;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.edgesForExtendedLayout = UIRectEdgeAll;
    
    
    [self setNavigationBarIsHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(backBtnPressed)];
    //self.view.height = kScreenSizeHeight+kStatusBarHeigth+kNavigationBarHeight;
    
    
   // [self _creaSubView];
    
}
- (void)backBtnPressed{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)_creaSubView{
    self.extendedLayoutIncludesOpaqueBars = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight,kScreenSizeWidth, kScreenSizeHeight-(kStatusBarHeight +kNavigationBarHeight)) style:UITableViewStylePlain];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    identify = @"studydetailcell";
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[StudydetailCell class] forCellReuseIdentifier:identify];
    
}
#pragma mark---UITabeView的协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data.count%3==0) {
        return self.data.count/3;
    }
    
    return (self.data.count/3+1);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudydetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
   
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<3; i++) {
        NSInteger index = indexPath.row*3 +i;
        if (index<self.data.count) {
             [array addObject:self.data[index]];
        }
       
    }
    cell.data =array.mutableCopy;
    
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;

}


#pragma mark---数据处理
- (void)setIsSearch:(BOOL)isSearch{
    _isSearch = isSearch;
    _seachView = [[NSBundle mainBundle] loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    _seachView.frame = CGRectMake(50, kStatusBarHeight, kScreenSizeWidth-50, kNavigationBarHeight);
    _seachView.imageNmae = @"home_btn_message_nm";
    _seachView.isSearch = NO;
    [self.view addSubview:_seachView];

}
- (void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    NSString *userid = [UserInfo shareUserInfo].userId;
    if (userid == nil) {
        userid = @"819";
    }
    NSDictionary *dic = @{
                          @"userid":userid,
                          @"wd":_keyword
                          };
    [self _reqestData:@"?c=search&m=bchjs" with:dic type:SHHttpRequestGet];

}

- (void)setTwoclassid:(NSString *)twoclassid{
    _twoclassid = twoclassid;
    NSDictionary *dic = @{
                          @"twoclassid":_twoclassid
                          };
    [self _reqestData:@"?c=wxjs&m=getlistbytwoclass" with:dic type:SHHttpRequestPost];

}
- (void)_reqestData:(NSString *)url with:(NSDictionary *)dic type:(NSInteger)typemethod{
    
    if (_data ==nil) {
        _data = [NSMutableArray array];
    }
    
    __weak DiseaPicViewController *weself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:typemethod subUrl:url parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                dispatch_async(dispatch_get_main_queue(),^{
            
                    NSArray *array = responseObject[@"list"];
                    for (NSDictionary *dic in array) {
                        
                        TwoclassMode *model = [[TwoclassMode alloc] initContentWithDic:dic];
                        
                        [weself.data addObject:model];
                        
                    }
                    [weself _creaSubView];
                   // [weself.tableView reloadData];

        });
        return ;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
