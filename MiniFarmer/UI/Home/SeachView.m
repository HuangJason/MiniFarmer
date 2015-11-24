//
//  SeachView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SeachView.h"
#import "UIView+UIViewController.h"
#import "MessageViewController.h"
#import "SearchViewController.h"
#import "UITextField+CustomTextField.h"


@implementation SeachView
- (void)awakeFromNib{
    
    _textView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    UITextField  *textfiled = (UITextField *)[_textView viewWithTag:101];
    textfiled.delegate = self;
    [textfiled setTextColor:[UIColor colorWithHexString:@"#a3a3a3"]];
    textfiled.font = kTextFont(14);

    _message.titleLabel.font = kTextFont18;
    [_message setTitleColor:[UIColor colorWithHexString:@"#a3a3a3"] forState:UIControlStateNormal];
    
}
//文字按钮
- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title.length != 0) {
        [_message setTitle:_title forState:UIControlStateNormal];
        [_message addTarget:self action:@selector(textAction:) forControlEvents:UIControlEventTouchUpInside];
    }


}
//图片按钮
- (void)setImageNmae:(NSString *)imageNmae{
   _imageNmae = imageNmae;
    if (_imageNmae.length != 0) {
        [_message setImage:[UIImage imageNamed:_imageNmae] forState:UIControlStateNormal];
        [_message addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
#pragma mark ----搜索栏按钮的点击事件
- (void)textAction:(UIButton *)button{
    [self.ViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)imageAction:(UIButton *)button{
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    
    

    messageVC.view.backgroundColor = [UIColor whiteColor];
   
    self.ViewController.tabBarController.hidesBottomBarWhenPushed = YES;
    
    [self.ViewController.navigationController pushViewController:messageVC animated:YES];

}
#pragma mark ----UITextfiled的协议方法
//将要开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_isSearch == NO) {
        
        SearchViewController *searchVC = [[SearchViewController alloc] init];
        
        [self.ViewController presentViewController:searchVC animated:YES completion:nil];
        
        
        return YES;
    }
    

  
    return YES;

}


@end
