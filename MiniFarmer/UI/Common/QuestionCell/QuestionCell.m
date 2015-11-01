//
//  QuestionCell.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/18.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuestionCell.h"
#import "AnswersButton.h"


#define kLeftSpace  12

@interface QuestionCell()
{
    UILabel *_contentLable;
    UIImageView *_categoryImgView;
    UILabel *_categoryLabel;
    UIImageView *_contentImgView1;
    UIImageView *_contentImgView2;
    UIImageView *_contentImgView3;
    
    UIView *_bottomView;
    UIImageView *_userIcon;
    UILabel *_nameLabel;
    UILabel *_locationLabel;
//    UIImageView *_hdImgView;
//    UILabel *_hdLabel;
//    UIImageView *_wlhdImgView;
    AnswersButton *_ansBtn;
    AnswersButton *_myAnsBtn;
    
    QuestionCellSource *_qSource;
}

@end

@implementation QuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //问题描述
        _contentLable = [UILabel new];
        _contentLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_contentLable];
        _contentLable.font = kTextFont16;
        _contentLable.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLable.textColor = [UIColor blackColor];
        _contentLable.numberOfLines = 0;
        
        //问题类型图片
        _categoryImgView = [UIImageView new];
        [self.contentView addSubview:_categoryImgView];
        
        //问题类型
        _categoryLabel = [UILabel new];
        [self.contentView addSubview:_categoryLabel];
        
        //内容图片
        _contentImgView1 = [UIImageView new];
        [self.contentView addSubview:_contentImgView1];
        
        _contentImgView2 = [UIImageView new];
        [self.contentView addSubview:_contentImgView2];
        
        _contentImgView3 = [UIImageView new];
        [self.contentView addSubview:_contentImgView3];
        
        //底部view
        [self bottemViewInit];
        
        //[self addViewConstraint];
    }
    
    return self;
}

- (void)bottemViewInit
{
    _bottomView = [UIView new];
    [self.contentView addSubview:_bottomView];
    
    _userIcon = [UIImageView new];
    [_bottomView addSubview:_userIcon];
    
    //用户名
    _nameLabel = [UILabel new];
    [_bottomView addSubview:_nameLabel];
    _nameLabel.font = kTextFont14;
    _nameLabel.textColor = kTextBlackColor;
    
    //地理位置
    _locationLabel = [UILabel new];
    [_bottomView addSubview:_locationLabel];
    _locationLabel.font = kTextFont12;
    _locationLabel.textColor = kTextLightBlackColor;
    
    //回答数
    _ansBtn = [AnswersButton new];
    [_bottomView addSubview:_ansBtn];
    [_ansBtn.titleLabel setFont:kTextFont12];
    [_ansBtn setTitleColor:kTextLightBlackColor forState:UIControlStateNormal];
    [_ansBtn setImage:[UIImage imageNamed:@"home_btn_answers_nm"] forState:UIControlStateNormal];
    //[_ansBtn setBackgroundColor:[UIColor yellowColor]];
    
    //我来回答
    _myAnsBtn = [AnswersButton new];
    [_bottomView addSubview:_myAnsBtn];
    [_myAnsBtn.titleLabel setFont:kTextFont14];
    [_myAnsBtn setTitleColor:kLightBlueColor forState:UIControlStateNormal];
    [_myAnsBtn setImage:[UIImage imageNamed:@"home_btn_myanswer_nm"] forState:UIControlStateNormal];
    //[_myAnsBtn setBackgroundColor:[UIColor yellowColor]];
}

- (void)updateBottemView
{
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLable.mas_bottom);
        make.left.equalTo(self.contentView).offset(kLeftSpace);
        //make.size.mas_equalTo(CGSizeMake(kMaxContentWidth, kBottemViewHeight));
        make.right.equalTo(self.contentView).offset(-kRightSpace);
        make.height.mas_equalTo(kBottemViewHeight);
    }];

    //TODO:头像
    [_userIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView).offset(9);
        make.left.equalTo(_bottomView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    _nameLabel.text = _qSource.qInfo.xm;
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIcon.mas_right).offset(8);
        make.centerY.equalTo(_userIcon);
        make.size.mas_equalTo(CGSizeMake(_qSource.nameLabelWidth,21));
    }];
    
    _locationLabel.text = _qSource.qInfo.location;
    [_locationLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(8);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(_qSource.locationLabelWidth, 21));
    }];
    
    //我来回答
    [_myAnsBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.mas_right);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(50, kBottemViewHeight));
    }];
    [_myAnsBtn setTitle:@"回答" forState:UIControlStateNormal];
    
    //回答数
    [_ansBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_myAnsBtn.mas_left).offset(-2);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(40, kBottemViewHeight));
    }];
    [_ansBtn setTitle:_qSource.qInfo.hdcs forState:UIControlStateNormal];
}

//- (void)addViewConstraint
//{
//    [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).offset(12);
//        make.left.equalTo(self.contentView).offset(kLeftSpace);
//    }];
//}

- (void)updateViewConstraint
{
    [_contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.left.equalTo(self.contentView).offset(kLeftSpace);
        make.size.mas_equalTo(_qSource.contentLabelSize);
    }];
    
    [self updateBottemView];
}

- (void)refreshWithQuestionCellSource:(QuestionCellSource *)source
{
    _qSource = source;
    QuestionInfo *info = _qSource.qInfo;
    
    _contentLable.text = info.wtms;
    
    [self updateViewConstraint];
}

@end
