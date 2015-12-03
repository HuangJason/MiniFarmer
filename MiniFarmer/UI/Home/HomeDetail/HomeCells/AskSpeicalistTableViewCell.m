//
//  AskSpeicalistTableViewCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/30.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskSpeicalistTableViewCell.h"
#import "AskSpecialistCellSubview.h"

@interface AskSpeicalistTableViewCell ()

@property (nonatomic, strong) AskSpecialistCellSubview *askSpecilistView;

@end

@implementation AskSpeicalistTableViewCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.askSpecilistView = [[[NSBundle mainBundle] loadNibNamed:@"AskSpecialistCellSubview" owner:self options:nil] lastObject];
        [self.contentView addSubview:self.askSpecilistView];
    }
    return self;
}

- (void)refreshDataWithModel:(id)model
{
    
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    //50是头像上下留下的间距 64是头像的高度
    return 50 + 64 + kLineWidth;
}

@end
