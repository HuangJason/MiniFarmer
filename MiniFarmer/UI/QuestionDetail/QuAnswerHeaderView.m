//
//  QuAnswerHeaderView.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/23.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuAnswerHeaderView.h"
#import "UIView+FrameCategory.h"
#import "PhotoViewController.h"
#import "UIViewAdditions.h"
#import "ReplyViewController.h"
#import "UserInfo.h"

#define kUserIconTopOffset      8
#define kUserIconLeftOffset     12
#define kUserIconWidth          26
#define kNameLeftSpace          (kUserIconLeftOffset+kUserIconWidth+ 10)
#define kNameTopPadding          16
#define kContentTopPadding       10
#define kTimeLabelTopPadding     20
#define kTimeLabelBottomPadding  10
#define kTimeLabelHeight            21


#define kPicutureHeigth      

@interface QuAnswerHeaderView()
{
    QuestionAnsModel *_ansModel;
    UIImageView *_userIcon;  //用户头像
    UILabel     *_nameLabel;  //用户名
    UILabel     *_contentLabel; //评论内容
    UIImageView *_contentImage; //评论中的图片
    UILabel     *_timeLabel;   //时间
    UIButton    *_favButton;  //点赞按钮
    UILabel     *_favCountLabel;//点赞数
    UILabel     *_lineLabelBottom;//下划线
    UIImageView *_adopSignView;
    //自己的问题
    UIButton    *_adopButton;
    
    
}
@end

@implementation QuAnswerHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        //分隔线
        UILabel *lineLabel = [UILabel new];
        [self.contentView addSubview:lineLabel];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(0.5);
        }];
        //头像
        _userIcon = [UIImageView new];
        _userIcon.userInteractionEnabled = YES;
    
        UITapGestureRecognizer *icontap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap)];
        [_contentImage addGestureRecognizer:icontap];
        
        [self.contentView addSubview:_userIcon];
        
        //用户名
        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];

        _nameLabel.font = kTextFont14;
        _nameLabel.textColor = kTextBlackColor;
        
        //采纳的按钮
        _adopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _adopButton.titleLabel.textColor = [UIColor blackColor];
        _adopButton.titleLabel.font = kTextFont14;
        [_adopButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_adopButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_no_enable_nm"] forState:UIControlStateNormal];
        [_adopButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_enable_nm"] forState:UIControlStateSelected];
        [_adopButton setTitle:@"采纳" forState:UIControlStateNormal];
        [_adopButton addTarget:self action:@selector(adoptionAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_adopButton];
         _adopButton.hidden = YES;
        
        //3.采纳的标志
        _adopSignView = [UIImageView new];
        [_adopSignView setImage:[UIImage imageNamed:@"home_question_adoptation_sign"]];
        _adopSignView.hidden = YES;
        [self.contentView addSubview:_adopSignView];
        
        
        //回答内容
        _contentLabel = [UILabel new];
        //_contentLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.font = kTextFont14;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLabel.textColor = kTextBlackColor;
        _contentLabel.numberOfLines = 0;
        //评论中附带的图片
        _contentImage = [UIImageView new];
        _contentImage.contentMode = UIViewContentModeScaleAspectFit;
        
        //1>添加地点击事件
        _contentImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *fdtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fdtap)];
        [_contentImage addGestureRecognizer:fdtap];
        [self.contentView addSubview:_contentImage];
        
        //时间
        _timeLabel = [UILabel new];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.font = kTextFont12;
        _timeLabel.textColor = kTextLightBlackColor;
        
        //点赞数
        _favCountLabel = [UILabel new];
        [self.contentView addSubview:_favCountLabel];
        _favCountLabel.font = kTextFont12;
        _favCountLabel.textColor = kTextLightBlackColor;
        
        //点赞按钮
        _favButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_favButton];
        [_favButton setBackgroundImage:[UIImage imageNamed:@"home_question_fav_btn_nm"] forState:UIControlStateNormal];
        [_favButton setBackgroundImage:[UIImage imageNamed:@"home_question_fav_btn_select"] forState:UIControlStateSelected];
        
        
        //分隔线
        _lineLabelBottom = [UILabel new];
        [self.contentView addSubview:_lineLabelBottom];
        _lineLabelBottom.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
        
        
        
    }
    
    return self;
}

#pragma mark- public

- (void)refreshWithAnsModel:(QuestionAnsModel *)ansModel
{
    _ansModel = ansModel;
   
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:ansModel.usertx] placeholderImage:nil];
    _userIcon.layer.cornerRadius = 13;
    _userIcon.layer.masksToBounds = YES;
    _nameLabel.text = _ansModel.xm;
    _contentLabel.text = _ansModel.hdnr;
    NSString *timeDes = [APPHelper describeTimeWithMSec:_ansModel.hdsj];
    _timeLabel.text = timeDes;
    
    BOOL iscn = _ansModel.iscn;
    
    _adopSignView.hidden =!iscn;
    
    NSURL *url = [NSURL URLWithString:ansModel.fdzp];
    
    [_contentImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Sys_defalut"]];
    _favCountLabel.text = _ansModel.dzcs;
    
   
    
    
    [self addViewConstraints];
}
- (void)setIsSelf:(BOOL)isSelf{
   
    _isSelf = isSelf;
    
    _adopButton.hidden = _isSelf;
    
    
    
}

+ (CGFloat)headerHeightWithAnsModel:(QuestionAnsModel *)ansModel
{
    CGFloat height;
    //昵称的高度
    CGSize nameLabelSize= [APPHelper getStringWordWrappingSize:ansModel.xm andConstrainToSize:CGSizeMake(200, 100) andFont:kTextFont14];
    //评论的内容
    CGSize contentSize= [APPHelper getStringWordWrappingSize:ansModel.hdnr andConstrainToSize:CGSizeMake(kScreenSizeWidth-kNameLeftSpace, 10000) andFont:kTextFont14];
    //图片的高度
    
    //
    CGFloat imgheigth;
    
    if (ansModel.fdzp.length != 0) {
        imgheigth  = 60+26;
    }else{
        imgheigth = 0;
    
    }
    
    height = kNameTopPadding +nameLabelSize.height +kContentTopPadding + contentSize.height + kTimeLabelTopPadding +kTimeLabelHeight +kTimeLabelBottomPadding+imgheigth;
    ;
    return height;
}

#pragma mark- private
- (void)addViewConstraints
{
    //TODO:头像
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kUserIconTopOffset);
        make.left.equalTo(self).offset(kUserIconLeftOffset);
        make.size.mas_equalTo(CGSizeMake(kUserIconWidth, kUserIconWidth));
    }];
    //昵称
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kNameTopPadding);
        make.left.equalTo(_userIcon.mas_right).offset(12);
    }];
    
    //采纳按钮
    [_adopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    
    }];
    //采纳的标志
    [_adopSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.size.mas_equalTo(CGSizeMake(38, 38));
        
    }];
    
    
    
    
    //评论
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(kContentTopPadding);
        make.left.equalTo(_nameLabel);
        make.right.equalTo(self.mas_right).offset(-12);
    }];
    
    //附带的图片
    [_contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_ansModel.fdzp.length == 0) {
            make.top.equalTo(_contentLabel.mas_bottom).offset(0);
            make.left.equalTo(_contentLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(0,0));
        }else{
        
        make.top.equalTo(_contentLabel.mas_bottom).offset(10);
        make.left.equalTo(_contentLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(60, 60));
            
        }
        
    }];
    
    //回答时间
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentImage.mas_bottom).offset(16);
        make.left.equalTo(_contentLabel.mas_left);
        make.right.equalTo(_favButton.mas_left).offset(10);
       // make.bottom.equalTo(self).offset(-16);
        
    }];
    
    //点赞按钮
    [_favButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_timeLabel.mas_bottom);
        //make.left.equalTo(_nameLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(_favCountLabel.mas_left).offset(-5);
    }];
   //点赞数
    [_favCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_top
                         );
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(10);
       // make.bottom.equalTo(self).offset(-16);
        make.left.equalTo(_favButton.mas_right).offset(5);
    }];
    
    //底部分割线
    [_lineLabelBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        //当有追问时缩进50
        if (_ansModel.relist.count == 0 ) {
          make.left.equalTo(self.contentView);
        }else{
          make.left.equalTo(self.contentView).offset(50);
        }
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

#pragma mark ----图片的点击事件
- (void)iconTap{


}
- (void)fdtap{
    
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:_ansModel.fdzp, nil];
    
    photoVC.imageUrls = array;
    [self.viewController.navigationController pushViewController:photoVC animated:YES];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    ReplyViewController *replyVC = [[ReplyViewController alloc] init];
    
    replyVC.model = _ansModel;
    replyVC.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:replyVC animated:YES];

}
//采纳
- (void)adoptionAction:(UIButton *)button{

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否采纳这个建议" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;

    [alertView show];
    
}
#pragma mark---UIAlertView协议方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *userid = [UserInfo shareUserInfo].userId;
    

    
    NSDictionary *dic = @{
                          @"id":_ansModel.ansid,
                          @"userid":userid
                          };

    
    if (buttonIndex == 1) {//采纳
        [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=tw&m=save_cn" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"msg"]isEqualToString:@"success" ]) {
                [self showWeakPromptViewWithMessage:@"采纳成功"];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
        
    }

}
@end
