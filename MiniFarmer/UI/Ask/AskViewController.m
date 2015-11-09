//
//  AskViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskViewController.h"
#import "BaseViewController+Navigation.h"
#import "GCPlaceholderTextView.h"
#import "AskCropNameView.h"
#import "AskSendModel.h"

#define kPlaceHolderText @"请描述作物的异常情况和您的问题, 越详细专家越好给您准确的回答哟! (必填)"


@interface AskViewController ()

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) GCPlaceholderTextView *askTextView;
@property (nonatomic, strong) GCPlaceholderTextView *nameTextView;
@property (nonatomic, strong) UIScrollView *askScrollview;
@property (nonatomic, strong) AskCropNameView *askCropNameView;
@property (nonatomic, strong) UIButton *addImageButton;
@end

@implementation AskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setStatusBarColor:[UIColor colorWithHexString:@"f8f8f8"]];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(dismissAskVC:)];
    [self setBarTitle:@"我的问题"];
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"a3a3a3"] heigth:kLineWidth];
    [self addSubviews];
    [self addGesture];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarIsHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavigationBarIsHidden:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - event
- (void)dismissAskVC:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendAsk:(UIButton *)btn
{
    //判断问题描述是否为空
    if (!self.askTextView.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"问题描述不能为空"];
        return;
    }
    else if (!self.askCropNameView.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"作物名称不能为空"];
        return;
    }
    NSDictionary *dic = @{@"c":@"tw",@"m":@"savetw",@"useid":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userId]],@"mobile":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userLoginNumber]],@"zjid":@"",@"wtzw":self.askCropNameView.text,@"wtms":self.askTextView.text};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        AskSendModel *sendModel = [[AskSendModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
        if ([sendModel.msg isEqualToString:@"success"])
        {
            [self.view showWeakPromptViewWithMessage:@"发送成功"];
        }
        else
        {
            [self.view showWeakPromptViewWithMessage:@"发送失败"];
 
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view showWeakPromptViewWithMessage:@"发送失败"];

    }];
    
    
    
}


- (void)addImages:(UIButton *)btn
{
    //添加图片 进入相册进行选择
}



#pragma mark - subviews
- (void)addSubviews
{
    [self.view addSubview:self.askScrollview];
    [self.view addSubview:self.sendButton];
    [self.askScrollview addSubview:self.askTextView];
    [self.view addSubview:self.askCropNameView];
    [self.view addSubview:self.addImageButton];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    }];
    
    CGRect subRect = self.view.bounds;
    subRect.origin.y = kStatusBarHeight + kNavigationBarHeight + kLineWidth;
    [self.askScrollview setFrame:subRect];
    
    subRect.origin.x = 12;
    subRect.origin.y = 12 ;
    subRect.size.width = kScreenSizeWidth - 2 * 12;
    subRect.size.height = 160;
    self.askTextView.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.askTextView.frame);
    subRect.size.width = kScreenSizeWidth - 12;
    subRect.size.height = 48;
    self.askCropNameView.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.askCropNameView.frame) + 18;
    subRect.size = CGSizeMake(112, 112);
    self.addImageButton.frame = subRect;
    
}

- (UIScrollView *)askScrollview
{
    if (!_askScrollview)
    {
        _askScrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _askScrollview.showsHorizontalScrollIndicator = NO;
    }
    return _askScrollview;
}

- (UIButton *)sendButton
{
    if (!_sendButton)
    {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundColor:[UIColor orangeColor]];
        [_sendButton addTarget:self action:@selector(sendAsk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UITextView *)askTextView
{
    if (!_askTextView)
    {
        _askTextView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectZero];
        _askTextView.textColor = [UIColor colorWithHexString:@"a3a3a3"];
        _askTextView.font = kTextFont(14);
        _askTextView.placeholderColor = _askTextView.textColor;
        _askTextView.placeholder = kPlaceHolderText;
        
    }
    return _askTextView;
}

- (AskCropNameView *)askCropNameView
{
    if (!_askCropNameView)
    {
        _askCropNameView = [[AskCropNameView alloc] initWithFrame:CGRectZero];
        
    }
    return _askCropNameView;
}

- (UIButton *)addImageButton
{
    if (!_addImageButton)
    {
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setBackgroundImage:[UIImage imageNamed:@"asd_btn_addimage"] forState:UIControlStateNormal];
        [_addImageButton addTarget:self action:@selector(addImages:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
}

@end
