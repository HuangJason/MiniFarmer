//
//  SortView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SortView.h"


@implementation SortView


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _createButton];
    }
    return self;
    
}
- (UIButton *)_createButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"home_search_sort_nm"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"home_search_sort_select"] forState:UIControlStateSelected];
    
    
    return button;
}

- (void)awakeFromNib{

    _title.textColor = [UIColor colorWithHexString:@"#999999"];
    _title.font = kTextFont14;
    
    _history.textColor = [UIColor colorWithHexString:@"#999999"];
    _history.font = kTextFont14;
    _dividine.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];

    
}
- (void)setData:(NSArray *)data{
    _data = data;
    
    CGFloat itemWith = (kScreenSizeWidth-16*6)/5;
    
    for (int i = 0; i< data.count; i++) {
        NSString *title = data[i];
        UIButton *item = [self _createButton];
        item.tag = i+1;
        item.frame = CGRectMake(i*itemWith +16*(i+1),40,itemWith, 27);
        [item setTitle:title forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        item.titleLabel.font = kTextFont12;
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        if (item.tag == 1) {
            item.selected = YES;
        }
        
    }
    _currentIndex = 1;
    
}
- (void)itemAction:(UIButton *)button{
    if (_currentIndex!=button.tag) {
        UIButton *item = (UIButton *)[self viewWithTag:_currentIndex];
        item.selected = NO;
        button.selected = YES
        ;
    }
    _currentIndex = button.tag;


}


@end
