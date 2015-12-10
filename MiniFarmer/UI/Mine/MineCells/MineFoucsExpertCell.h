//
//  MineFoucsExpertCell.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/9.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseTableViewCell.h"
#import "MineExpertModel.h"

@interface MineFoucsExpertCell : MineBaseTableViewCell

@property (nonatomic, strong, readonly) MineExpertList *jsonModel;

- (void)setExpertModel:(MineExpertList *)model;

@end
