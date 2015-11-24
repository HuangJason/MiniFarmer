//
//  SearchViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SearchViewController.h"
#import "SeachView.h"
#import "SortView.h"
#import "UIView+FrameCategory.h"

@interface SearchViewController ()

@end

@implementation SearchViewController{
    SeachView *_seachView;
    SortView *_sortView;
    UITableView *_tableView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    [self _CreateSubView];
    
    
    
    
}
- (void)_CreateSubView{
    //1.搜索栏
    _seachView = [[NSBundle mainBundle]loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    // _seachView.backgroundColor = [UIColor redColor];
    _seachView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    _seachView.frame = CGRectMake(0,kStatusBarHeight,kScreenSizeWidth , kNavigationBarHeight);
    _seachView.imageNmae = nil;
    _seachView.title = @"取消";
    _seachView.isSearch = YES;
    [self.view addSubview:_seachView];
    
    //2.分类栏
    _sortView = [[NSBundle mainBundle]loadNibNamed:@"SortView" owner:self options:nil].lastObject;
    _sortView.frame = CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kScreenSizeWidth, 100);
    [self.view addSubview:_sortView];
    
    
    
    //3.历史记录
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _sortView.bottom,kScreenSizeHeight,150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
                  
                  
    [self.view addSubview:_tableView];
    
    


}
#pragma mark ---- UITableView的协议协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
