//
//  HeaderLoginView.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "HeaderLoginView.h"

@interface HeaderLoginView ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIButton *headerIconBT;
@property (nonatomic, strong) UIButton *speiclistTypeBT;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nongRenMoneyCountLabel;
@property (nonatomic, strong) UILabel *nongRenMoneyLabel;
@property (nonatomic, strong) UILabel *acceptLabel;
@property (nonatomic, strong) UILabel *acceptCountLabel;
@property (nonatomic, strong) UILabel *invitedCodelLabel;
@property (nonatomic, strong) UILabel *invitedCodeCountlLabel;
@property (nonatomic, strong) UIImageView *line1;
@property (nonatomic, strong) UIImageView *line2;




@end

@implementation HeaderLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}


- (void)addSubviews
{
    [self addSubview:self.headerImageView];
    [self addSubview:self.headerIconBT];
    [self addSubview:self.speiclistTypeBT];
    [self addSubview:self.nameLabel];
    [self addSubview:self.nongRenMoneyLabel];
    [self addSubview:self.nongRenMoneyCountLabel];
    [self addSubview:self.acceptCountLabel];
    [self addSubview:self.acceptLabel];
    [self addSubview:self.invitedCodeCountlLabel];
    [self addSubview:self.invitedCodelLabel];
    [self addSubview:self.line1];
    [self addSubview:self.line2];

    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.headerIconBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_top).offset(45);
        make.centerX.equalTo(self.headerImageView);
        make.size.mas_equalTo(CGSizeMake(76, 76));
    }];
    
    [self.speiclistTypeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerIconBT.mas_centerY).offset(38);
        make.centerX.equalTo(self.headerIconBT.mas_centerX);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.speiclistTypeBT.mas_bottom).offset(24);
        make.centerY.equalTo(self.speiclistTypeBT.mas_centerY);
    }];
    CGFloat dwidth = (kScreenSizeWidth - 2 * kLineWidth) / 3.0;
    [self.nongRenMoneyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(dwidth / 2.0));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(16);
    }];
    
    [self.nongRenMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nongRenMoneyCountLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.nongRenMoneyCountLabel.mas_centerX);
    }];
    
    [self.acceptCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(dwidth + kLineWidth + dwidth / 2.0));
        make.centerY.equalTo(self.nongRenMoneyCountLabel.mas_centerY);
    }];
    
    [self.acceptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.acceptCountLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.acceptCountLabel.mas_centerX);
    }];
    
    [self.invitedCodeCountlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(2 * dwidth + 2 * kLineWidth + dwidth / 2.0));
        make.centerY.equalTo(self.nongRenMoneyCountLabel);
    }];
    
    [self.invitedCodelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.invitedCodeCountlLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.invitedCodeCountlLabel.mas_centerX);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(dwidth));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(kLineWidth, 22));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(dwidth * 2 + kLineWidth));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(kLineWidth, 22));

    }];


}

- (UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_headerImageView setImage:[UIImage imageNamed:@"mine_back_image"]];
    }
    return _headerImageView;
}

- (UIButton *)headerIconBT
{
    if (!_headerIconBT)
    {
        _headerIconBT = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerIconBT.layer.cornerRadius = 38;
        _headerIconBT.layer.borderWidth = 3;
    }
    return _headerIconBT;
}

- (UIButton *)speiclistTypeBT
{
    if (!_speiclistTypeBT)
    {
        _speiclistTypeBT = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _speiclistTypeBT;
}


- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = kTextFont(18);
        [_nameLabel setShadowWithRadius:1 offset:CGSizeMake(0, 2) shaowColor:[UIColor colorWithHexString:@"333333"]];
    }
    
    return _nameLabel;
}

- (UILabel *)nongRenMoneyCountLabel
{
    if (!_nongRenMoneyCountLabel)
    {
        _nongRenMoneyCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nongRenMoneyCountLabel.textColor = [UIColor whiteColor];
        _nongRenMoneyCountLabel.font = kTextFont(18);
        [_nongRenMoneyCountLabel setShadowWithRadius:1
                                 offset:CGSizeMake(0, 2)
                             shaowColor:[UIColor colorWithHexString:@"333333"]];

    }
    return _nongRenMoneyCountLabel;
}

- (UILabel *)nongRenMoneyLabel
{
    if (!_nongRenMoneyLabel)
    {
        _nongRenMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nongRenMoneyLabel.textColor = [UIColor whiteColor];
        _nongRenMoneyLabel.font = kTextFont(12);
        [_nongRenMoneyLabel setShadowWithRadius:1
                                              offset:CGSizeMake(0, 2)
                                          shaowColor:[UIColor colorWithHexString:@"333333"]];
        
    }
    return _nongRenMoneyLabel;
}

- (UILabel *)acceptCountLabel
{
    if (!_acceptCountLabel)
    {
        _acceptCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _acceptCountLabel.textColor = [UIColor whiteColor];
        _acceptCountLabel.font = kTextFont(18);
        [_acceptCountLabel setShadowWithRadius:1
                                         offset:CGSizeMake(0, 2)
                                     shaowColor:[UIColor colorWithHexString:@"333333"]];
        
    }
    return _acceptCountLabel;

}


- (UILabel *)acceptLabel
{
    if (!_acceptLabel)
    {
        _acceptLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _acceptLabel.textColor = [UIColor whiteColor];
        _acceptLabel.font = kTextFont(12);
        [_acceptLabel setShadowWithRadius:1
                                        offset:CGSizeMake(0, 2)
                                    shaowColor:[UIColor colorWithHexString:@"333333"]];
        
    }
    return _acceptLabel;
    
}

- (UILabel *)invitedCodelLabel
{
    if (!_invitedCodelLabel)
    {
        _invitedCodelLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _invitedCodelLabel.textColor = [UIColor whiteColor];
        _invitedCodelLabel.font = kTextFont(12);
        [_invitedCodelLabel setShadowWithRadius:1
                                   offset:CGSizeMake(0, 2)
                               shaowColor:[UIColor colorWithHexString:@"333333"]];
        
    }
    return _invitedCodelLabel;
}


- (UILabel *)invitedCodeCountlLabel
{
    if (!_invitedCodeCountlLabel)
    {
        _invitedCodeCountlLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _invitedCodeCountlLabel.textColor = [UIColor whiteColor];
        _invitedCodeCountlLabel.font = kTextFont(18);
        [_invitedCodeCountlLabel setShadowWithRadius:1
                                         offset:CGSizeMake(0, 2)
                                     shaowColor:[UIColor colorWithHexString:@"333333"]];
        
    }
    return _invitedCodeCountlLabel;
}

- (UIImageView *)line1
{
    if (!_line1)
    {
        _line1 = [[UIImageView alloc] initWithFrame:CGRectZero];
        _line1.backgroundColor = [UIColor whiteColor];
    }
    return _line1;
}

- (UIImageView *)line2
{
    if (!_line2)
    {
        _line2 = [[UIImageView alloc] initWithFrame:CGRectZero];
        _line2.backgroundColor = [UIColor whiteColor];
    }
    return _line2;
}

#pragma mark - refresh
- (void)refreshUIWithModel:(id)model
{
    //更新用户的信息
}

@end
