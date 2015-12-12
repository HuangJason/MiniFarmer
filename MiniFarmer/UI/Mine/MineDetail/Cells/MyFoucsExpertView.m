//
//  MyFoucsExpertView.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyFoucsExpertView.h"

@interface MyFoucsExpertView ()
/// 头像
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
/// 姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/// eg:院士
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
/// eg:农技推广专家
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;
/// eg:擅长领域
@property (weak, nonatomic) IBOutlet UILabel *goodAtLabel;
/// 提问按钮
@property (weak, nonatomic) IBOutlet UIButton *askBtn;
@end

@implementation MyFoucsExpertView

- (void)awakeFromNib
{
    self.askBtn.layer.cornerRadius = 8;
    self.askBtn.layer.borderWidth = 0.5f;
    self.askBtn.layer.borderColor = [UIColor colorWithHexString:@"#0099ff"].CGColor;
}

/// 提问按钮点击
- (IBAction)askBtnClick:(id)sender {
}

@end
