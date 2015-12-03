//
//  BaseTableViewCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/30.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseTableViewCell.h"

#define kDidpaceToSide 0


@implementation BaseTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.line = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.line setBackgroundColor:[UIColor colorWithHexString:@"e4e4e4"]];
        [self.contentView addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(kDidpaceToSide);
            make.right.equalTo(self.contentView.mas_right).offset(-kDidpaceToSide);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-kLineWidth);
            make.height.equalTo(@(kLineWidth));
            
        }];
    }
    return self;
}


- (void)setHiddenLine:(BOOL)hidden
{
    [self.line setHidden:hidden];
}

- (void)refreshDataWithModel:(id)model
{
    
}
+ (CGFloat)cellHeightWihtModel:(id)model
{
    return 0.0;
}

@end
