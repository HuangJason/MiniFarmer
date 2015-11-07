//
//  BaseViewController+Navigation.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/1.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController+Navigation.h"

@implementation BaseViewController (Navigation)

- (void)setNavigationBarIsHidden:(BOOL)hidden
{
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)setBarLeftDefualtButtonWithTarget:(id)target action:(SEL)action
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login_btn_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"login_btn_back"] forState:UIControlStateHighlighted];
    [backButton addTarget:target action:action
         forControlEvents:UIControlEventTouchUpInside];
    
    [self setLineToBarBottomWithColor:RGBCOLOR(169, 169, 169) heigth:kLineWidth];

    [self.view addSubview:backButton];
}

- (void)setBarRightDefaultButtonWithTarget:(id)target action:(SEL)action
{
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSizeWidth - 16 - 44,kStatusBarHeight,44, 44)];
    [rigthButton setTitle:@"注册" forState:UIControlStateNormal];
    [rigthButton setTitle:@"注册" forState:UIControlStateHighlighted];
    rigthButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rigthButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [rigthButton setBackgroundColor:[UIColor clearColor]];
    [rigthButton addTarget:target action:action
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigthButton];
}

- (void)setBarTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 78, 20)];
    label.textColor = RGBCOLOR(57, 57, 57);
    label.center = CGPointMake(kScreenSizeWidth / 2, 22 + kStatusBarHeight);
    label.text = title;
    [self.view addSubview:label];
    
}

- (void)setLineToBarBottomWithColor:(UIColor *)color heigth:(CGFloat)heigth
{
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + 44, kScreenSizeWidth, heigth)];
    [line setBackgroundColor:color];
    [self.view addSubview:line];
}


- (void)setLeftDefualtButtonBackWithTarget:(id)target action:(SEL)action{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0,44, 44)];
    [backButton setImage:[UIImage imageNamed:@"login_btn_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"login_btn_back"] forState:UIControlStateHighlighted];

    [backButton addTarget:target action:action
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)setRightDefaultButtonBackWithTarget:(id)target action:(SEL)action
{
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,44, 44)];
    [rigthButton setTitle:@"注册" forState:UIControlStateNormal];
    [rigthButton setTitle:@"注册" forState:UIControlStateHighlighted];
    rigthButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rigthButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [rigthButton setBackgroundColor:[UIColor clearColor]];
    [rigthButton addTarget:target action:action
          forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rigthButton]];
}

@end
