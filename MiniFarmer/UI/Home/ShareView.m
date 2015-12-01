//
//  ShareView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/29.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ShareView.h"
#import "UIView+UIViewController.h"
#import "UserInfo.h"
#import "LoginViewController.h"
#import "HomeViewController.h"




@implementation ShareView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;

}
- (void)awakeFromNib{
    [_back setImage:[UIImage imageNamed:@"home_study_back_btn"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [_gohome setImage:[UIImage imageNamed:@"home_study_gohome_btn"] forState:UIControlStateNormal];
    [_gohome addTarget:self action:@selector(gohome:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_collection setImage:[UIImage imageNamed:@"home_study_collection_nm"] forState:UIControlStateNormal];
    [_collection setImage:[UIImage imageNamed:@"home_study_collection_select"] forState:UIControlStateSelected];
    _collection.backgroundColor = [UIColor clearColor];
    [_collection addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_share setImage:[UIImage imageNamed:@"home_study_share_btn"] forState:UIControlStateNormal];
    [_share addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)backAction:(UIButton *)button{
  
    [self.ViewController.navigationController popViewControllerAnimated:YES];
    
}
- (void)gohome:(UIButton *)button{
    [self.ViewController.navigationController popToRootViewControllerAnimated:YES];

}
- (void)collectionAction:(UIButton *)button{
    button.selected = !button.selected;
    NSString *userid = [UserInfo shareUserInfo].userId
    ;
    if (userid == nil) {
        button.selected = NO;
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.ViewController presentViewController:loginVC animated:YES completion:nil];
        loginVC.loginBackBlock = ^(){
            HomeViewController *vc = [[HomeViewController alloc] init];
            self.ViewController.view.window.rootViewController = vc;
        
        };
    }else {
        if (button.selected == YES) {//收藏
            [self _requestData:@"?c=wxjs&m=add_xjs_collection" type:YES];
            
        }else{//取消收藏
            [self _requestData:@"?c=wxjs&m=cancel_xjs_collection" type:NO];
        }
        

    
    }
    
    


}
- (void)shareAction:(UIButton *)button{
   


}

#pragma mark---收藏和取消技术
- (void)_requestData:(NSString *)url type:(BOOL)isclloection {
    NSString *userid = [UserInfo shareUserInfo].userId;
    NSString *bchid = _model.bachid;
    
    NSDictionary *dic = @{
                          @"userid":userid,
                          @"xjsid":_model.bachid
                              };
    __weak ShareView *weself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:url parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"success"]) {
            if (isclloection == YES) {
                [weself.ViewController.view showWeakPromptViewWithMessage:@"收藏成功"];
                
            }else{
                [weself.ViewController.view showWeakPromptViewWithMessage:@"取消收藏"];
                
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (isclloection == YES) {
            [weself.ViewController.view showWeakPromptViewWithMessage:@"收藏失败"];
            
        }else{
            [weself.ViewController.view showWeakPromptViewWithMessage:@"取消收藏失败"];
            
        }
    
    }];
    
}



@end
