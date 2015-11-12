//
//  QuCommonView.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuCommonView.h"

#define kLeftSpace              12
#define kRightSpace             12
#define kOutputViewTopPadding   10
#define kContentTopPadding      12
#define kMaxContentWidth        (kScreenSizeWidth-kLeftSpace-kRightSpace)
#define kMaxContentLabelHeight  20000
#define kMiddleViewHeight       26
#define kMiddleViewTopPadding   5
#define kPicPadding             3
#define kPicImgWidth            ((kMaxContentWidth-2*kPicPadding)/3.0)
#define kPicImgHeight           (kPicImgWidth/1.1)
#define kPicViewTopPadding      12


@interface QuCommonView()
{
    QuestionInfo *_qInfo;
    UIView *_outputView;
    UILabel *_contentLable;
    
    //中间view
    UIView *_middleView;
    UIImageView *_plantImgView;
    UILabel *_plantNameLabel;
    UILabel *_dateLable;
}
@end

@implementation QuCommonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _outputView = [UIView new];
        [self addSubview:_outputView];
        _outputView.backgroundColor = [UIColor whiteColor];
        [_outputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kOutputViewTopPadding);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        //问题描述
        _contentLable = [UILabel new];
        //_contentLable.backgroundColor = [UIColor redColor];
        [_outputView addSubview:_contentLable];
        _contentLable.font = kTextFont16;
        _contentLable.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLable.textColor = [UIColor blackColor];
        _contentLable.numberOfLines = 0;
        
        //
        [self middleViewInit];
    }
    
    return self;
}

#pragma mark- public
- (void)refreshWithQuestionInfo:(QuestionInfo *)info
{
    _qInfo = info;
    
    _contentLable.text = _qInfo.wtms;
    _plantNameLabel.text = _qInfo.zwmc;
    _dateLable.text = [self describeWithTwsj:info.twsj];
    [self updateViewConstraint];
}

#pragma mark- private
- (void)middleViewInit
{
    _middleView = [UIView new];
    //_middleView.backgroundColor = [UIColor greenColor];
    [_outputView addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLable.mas_bottom).offset(kMiddleViewTopPadding);
        make.left.equalTo(_contentLable);
        make.right.equalTo(self.mas_right).offset(-kRightSpace);
        make.height.mas_equalTo(kMiddleViewHeight);
    }];
    
    _plantImgView = [UIImageView new];
    [_middleView addSubview:_plantImgView];
    _plantImgView.image = [UIImage imageNamed:@"home_icon_plant"];
    [_plantImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView);
        make.left.equalTo(_middleView);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    _plantNameLabel = [UILabel new];
    [_middleView addSubview:_plantNameLabel];
    //_plantNameLabel.backgroundColor = [UIColor blueColor];
    _plantNameLabel.textColor = kTextLightBlackColor;
    _plantNameLabel.font = kTextFont12;
    [_plantNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView);
        make.left.equalTo(_plantImgView.mas_right).offset(5);
        make.height.mas_equalTo(kMiddleViewHeight);
    }];
    
    //分隔线
    UILabel *lineLabel = [UILabel new];
    [_middleView addSubview:lineLabel];
    lineLabel.backgroundColor = RGBCOLOR(238, 238, 238);
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_plantNameLabel.mas_right).offset(12);
        make.centerY.equalTo(_middleView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 16));
    }];
    
    //日期
    _dateLable = [UILabel new];
    [_middleView addSubview:_dateLable];
    //_dateLable.backgroundColor = [UIColor yellowColor];
    _dateLable.textColor = kTextLightBlackColor;
    _dateLable.font = kTextFont12;
    [_dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView);
        make.left.equalTo(lineLabel.mas_right).offset(12);
        make.height.mas_equalTo(kMiddleViewHeight);
    }];
}

//TODO:时间描述规则
- (NSString *)describeWithTwsj:(NSString *)twsj
{
    if (!twsj) {
        return @"";
    }
    
    long long curTimeMSec = (long long)([NSDate date].timeIntervalSince1970*1000);
    long long passTimeSec = (curTimeMSec - [twsj longLongValue])/1000;
    if (passTimeSec < 0) {
        return @"1小时前";
    }
    //换算成小时
    NSUInteger hours = passTimeSec/3600;
    if (!hours) {
        return @"1小时前";
    }
    
    NSUInteger days = hours/24;
    if (!days) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    
    NSUInteger years = days/365;
    if (!years) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    else{
        return [NSString stringWithFormat:@"%ld年前",years];
    }
}

- (void)updateViewConstraint
{
    CGSize contentLabelSize = [APPHelper getStringWordWrappingSize:_qInfo.wtms andConstrainToSize:CGSizeMake(kMaxContentWidth, kMaxContentLabelHeight) andFont:kTextFont16];
    
    [_contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_outputView).offset(kContentTopPadding);
        make.left.equalTo(_outputView).offset(kLeftSpace);
        make.size.mas_equalTo(contentLabelSize);
    }];
}



@end
