//
//  MineSegmentView.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSegmentView.h"

@implementation MineSegmentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.mineLineWidth.constant = kLineWidth;
}

@end
