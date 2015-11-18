//
//  MineBaseTableViewCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseTableViewCell.h"
#import "SettingModel.h"

@implementation MineBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)refreshDataWithModel:(id)model
{
    
}
+ (CGFloat)cellHeightWihtModel:(id)model
{
    SettingModel *settingModel = (SettingModel *)model;
    return settingModel.heigth.floatValue;
}


@end
