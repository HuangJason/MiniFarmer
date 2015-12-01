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


@interface DiseaPicViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation DiseaPicViewController{

    NSString *identify;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    return self.data.count/3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudydetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
   
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<3; i++) {
        NSInteger index = indexPath.row*3 +i;
        [array addObject:self.data[index]];
    }
    cell.data =array.mutableCopy;
    
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;

}


#pragma mark---数据处理

- (void)setTwoclassid:(NSString *)twoclassid{
    _twoclassid = twoclassid;
    [self _reqestData];

}
- (void)_reqestData{
    
    if (_data ==nil) {
        _data = [NSMutableArray array];
    }
    
    __weak DiseaPicViewController *weself = self;
    NSDictionary *dic = @{
                          @"twoclassid":_twoclassid
                          };
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:@"?c=wxjs&m=getlistbytwoclass" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
