//
//  MineReponseCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/19.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineReponseCell.h"

@interface MineReponseCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;

@end

@implementation MineReponseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setHiddenLine:YES];
    }
    return self;
}

- (void)refreshDataWithModel:(id)model
{
    
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    //内容的高度 + 14 + 时间的高度 + 20 + klinwidth
    return 20;
}


@end
