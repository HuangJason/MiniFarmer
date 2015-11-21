//
//  MineResponseImagesCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/19.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineResponseImagesCell.h"
#import "MyReponseModel.h"

#define kCountOfRow 3
#define kDwidth ceilf((kScreenSizeWidth - 12 * 2 - (kCountOfRow - 1)* 3) / kCountOfRow)

@interface MineResponseImagesCell ()
@property (nonatomic, strong) UIView *backContentView;
//内容label
@property (nonatomic, strong) UILabel *contentLabel;
//信息
@property (nonatomic, strong) UILabel *messageCountLabel;
//时间
@property (nonatomic, strong) UILabel *timeLabel;
//中间的分割线
@property (nonatomic, strong) UIImageView *imageLine;
///消息的图片
@property (nonatomic, strong) UIButton *messageBT;

@property (nonatomic, strong) NSMutableArray *imageButtons;

@property (nonatomic, strong) UIButton *imagesCountBT;

@end



@implementation MineResponseImagesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageButtons = [NSMutableArray arrayWithCapacity:3];
        
        self.backContentView = [[UIView alloc] initWithFrame:CGRectZero];

        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.messageCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.messageBT = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imagesCountBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.imagesCountBT setBackgroundColor:[UIColor blackColor]];
        [self.imagesCountBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [self.contentLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
        [self.timeLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.messageCountLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.imageLine setBackgroundColor:[UIColor colorWithHexString:@"e4e4e4"]];
        [self.messageBT setBackgroundImage:[UIImage imageNamed:@"mine_response_btn_nm"] forState:UIControlStateNormal];

      
        [self.contentView addSubview:self.backContentView];
        [self.backContentView addSubview:self.contentLabel];
        [self.backContentView addSubview:self.messageCountLabel];
        [self.backContentView addSubview:self.timeLabel];
        [self.backContentView addSubview:self.messageBT];
        
        //添加约束
        [self addButtons];
        [self addConstraintsToSubviews];
        
    }
    return self;
}

- (void)addButtons
{
    for (int i = 0; i < kCountOfRow; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.backContentView addSubview:button];
        [self.imageButtons addObject:button];
    }
}


- (void)addConstraintsToSubviews
{
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(12);
        make.right.equalTo(self.backContentView.mas_right).offset(-12);
        make.top.equalTo(self.backContentView.mas_top).offset(12);
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-14);
        make.bottom.equalTo(self.line.mas_bottom).offset(-20);
    }];
    
    [self.imageLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLabel.mas_right).offset(-20);
        make.centerY.equalTo(self.timeLabel.mas_centerY).offset(0);
        make.width.equalTo(@(kLineWidth));
        make.height.equalTo(@14);
    }];
    
    
    [self.messageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageLine.mas_right).offset(-20);
        make.centerY.equalTo(self.timeLabel.mas_centerY).offset(0);
    }];
    
    CGFloat dwidth = kDwidth;
    //buttons的约束
    for (int i = 0; i<self.imageButtons.count; i++)
    {
        UIButton *btn = [self.imageButtons objectAtIndex:i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(14);
            make.left.equalTo(self.backContentView).offset(12 + (i + 12) *dwidth);
            make.width.equalTo(@(dwidth));
            make.height.equalTo(@(dwidth));
        }];
        
        
    }
    
    [self.imagesCountBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-12-4);
        make.bottom.equalTo(self.messageCountLabel.mas_top).offset(-15-4);
    }];

    
}

- (void)tapBtn:(UIButton *)btn
{
    
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    //内容的高度 + 图片的宽度kdwidth + 14 * 2 + 12 + timelabel的高度 + 20 + klinewidth
    return 20;
}

- (void)refreshDataWithModel:(id)model
{
    List *list = (List *)model;
    [self.imagesCountBT setHidden:list.images.count >= kCountOfRow];
    NSString *title = [NSString stringWithFormat:@"共%d张",list.images.count];
    [self.imagesCountBT setTitle:title forState:UIControlStateNormal];
    
}

- (void)setImagesToBtnWithArr:(List *)list
{
    for (int i = 0; i<self.imageButtons.count > list.images.count ? list.images.count : self.imageButtons.count; i++)
    {
        UIButton *btn = [self.imageButtons objectAtIndex:i];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:list.images[i]] forState:UIControlStateNormal];
        [btn setEnabled:YES];
    }
    for (int j = self.imageButtons.count - 1; j > list.images.count; j--) {
        UIButton *btn = [self.imageButtons objectAtIndex:j];
        [btn setEnabled:NO];
    }
}

@end
