//
//  MineFocusViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineFocusViewController.h"
#import "YHSegmentView.h"

@interface MineFocusViewController ()<YHSegmentViewDelegate>

@property (nonatomic, strong) YHSegmentView *segmentView;

@end

@implementation MineFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarTitle:@"关注的人"];
    
    [self.view addSubview:self.segmentView];
    [self setupSegmentItem];
    [self.segmentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).offset(self.yDispaceToTop);
        make.size.mas_equalTo(CGSizeMake(kScreenSizeWidth, 47));
    }];

}

- (void)setupSegmentItem
{
    NSArray *titles = @[@"专家",@"农友"];
    
    for (NSString *title in titles) {
        YHSegmentItem *item = [[YHSegmentItem alloc] init];
        item.title = title;
        item.font = [UIFont systemFontOfSize:16];
        [self.segmentView addSegmentItem:item];
    }
}


#pragma mark - YHSegmentViewDelegate
- (void)segmentView:(YHSegmentView *)segmentView didSelectedAtIndex:(NSInteger)index
{
    
}

#pragma mark - init views
-(YHSegmentView *)segmentView
{
    if (!_segmentView)
    {
        _segmentView = [[YHSegmentView alloc] init];
        _segmentView.backgroundColor = [UIColor whiteColor];
        _segmentView.itemToLeft = 64;
        _segmentView.directionLineHeigth = 4;
        _segmentView.itemsDispace = 110;
        _segmentView.textSelectedColor = [UIColor colorWithHexString:@"#ff6633"];
        _segmentView.textNormalColor = [UIColor colorWithHexString:@"#666666"];
        _segmentView.directionLineColor = [UIColor colorWithHexString:@"#ff6633"];
        _segmentView.bottomLineHeigth = 1;
        _segmentView.bottomLineColor = [UIColor colorWithHexString:@"#e4e4e4"];
        _segmentView.delegate = self;
    }
    return _segmentView;
}




@end
