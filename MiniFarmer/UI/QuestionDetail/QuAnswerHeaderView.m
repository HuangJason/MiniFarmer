//
//  QuAnswerHeaderView.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/23.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuAnswerHeaderView.h"

#define kUserIconTopOffset      10
#define kUserIconLeftOffset     10
#define kUserIconWidth          20
#define kNameLeftSpace          (kUserIconLeftOffset+kUserIconWidth+ 10)
#define kNameTopPadding         15
#define kContentTopPadding       10
#define kTimeLabelTopPadding     30
#define kTimeLabelBottomPadding  10
#define kTimeLabelHeight            21

@interface QuAnswerHeaderView()
{
    QuestionAnsModel *_ansModel;
    UIImageView *_userIcon;
    UILabel     *_nameLabel;
    UILabel     *_contentLabel;
    UILabel     *_timeLabel;
    UIButton    *_favButton;
    UILabel     *_favCountLabel;
}
@end

@implementation QuAnswerHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kBgGrayColor;
        //分隔线
        UILabel *lineLabel = [UILabel new];
        [self.contentView addSubview:lineLabel];
        lineLabel.backgroundColor = kSeparatorColor;
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(0.5);
        }];
        //头像
        _userIcon = [UIImageView new];
        [self.contentView addSubview:_userIcon];
        
        //用户名
        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        //_nameLabel.backgroundColor = [UIColor blueColor];
        _nameLabel.font = kTextFont14;
        _nameLabel.textColor = kTextBlackColor;
        
        //回答内容
        _contentLabel = [UILabel new];
        //_contentLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.font = kTextFont14;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLabel.textColor = kTextBlackColor;
        _contentLabel.numberOfLines = 0;
        
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
        //[_favButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //分隔线
        UILabel *lineLabelBottom = [UILabel new];
        [self.contentView addSubview:lineLabelBottom];
        lineLabelBottom.backgroundColor = kSeparatorColor;
        [lineLabelBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        //添加约束
        [self addViewConstraints];
    }
    
    return self;
}

#pragma mark- public
- (void)refreshWithAnsModel:(QuestionAnsModel *)ansModel
{
    _ansModel = ansModel;
    //[self addViewConstraints];
    _nameLabel.text = _ansModel.xm;
    _contentLabel.text = _ansModel.hdnr;
    NSString *timeDes = [APPHelper describeTimeWithMSec:_ansModel.hdsj];
    _timeLabel.text = timeDes;
    _favCountLabel.text = _ansModel.dzcs;
    [_favButton setTitle:@"测试" forState:UIControlStateNormal];
}

+ (CGFloat)headerHeightWithAnsModel:(QuestionAnsModel *)ansModel
{
    CGFloat height;
    CGSize nameLabelSize= [APPHelper getStringWordWrappingSize:ansModel.xm andConstrainToSize:CGSizeMake(200, 100) andFont:kTextFont14];
    CGSize contentSize= [APPHelper getStringWordWrappingSize:ansModel.hdnr andConstrainToSize:CGSizeMake(kScreenSizeWidth-kNameLeftSpace, 10000) andFont:kTextFont14];
    height = kNameTopPadding +nameLabelSize.height +kContentTopPadding + contentSize.height + kTimeLabelTopPadding +kTimeLabelHeight +kTimeLabelBottomPadding;
    return height;
}

#pragma mark- private
- (void)addViewConstraints
{
    //TODO:头像
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kUserIconTopOffset);
        make.left.equalTo(self).offset(kUserIconTopOffset);
        make.size.mas_equalTo(CGSizeMake(kUserIconWidth, kUserIconWidth));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kNameTopPadding);
        make.left.equalTo(_userIcon.mas_right).offset(8);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(kContentTopPadding);
        make.left.equalTo(_nameLabel);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    
    //回答时间
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(kTimeLabelTopPadding);
        make.left.equalTo(_nameLabel);
        make.right.equalTo(_favButton.mas_left).offset(10);
    }];
    
    [_favButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel);
        //make.left.equalTo(_nameLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 11));
        make.right.equalTo(_favCountLabel.mas_left).offset(-5);
    }];
    
    
    [_favCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(20);
        //make.left.equalTo(_favButton.mas_right).offset(5);
    }];
}

@end
